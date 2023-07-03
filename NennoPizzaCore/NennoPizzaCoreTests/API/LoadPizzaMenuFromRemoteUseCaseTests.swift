//
//  LoadPizzaMenuFromRemoteUseCaseTests.swift
//  NennoPizzaCoreTests
//
//  Created by Vadym Bohdan on 02.07.2023.
//

import XCTest
import NennoPizzaCore

final class LoadPizzaMenuFromRemoteUseCaseTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    func test_load_requestsDataFromURL() {
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        
        sut.load { _ in }
        
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_loadTwice_requestsDataFromURLTwice() {
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        
        sut.load { _ in }
        sut.load { _ in }
        
        XCTAssertEqual(client.requestedURLs, [url, url])
    }
    
    func test_load_deliversErrorOnClientError() {
        let (sut, client) = makeSUT()
        
        expect(sut, toCompleteWith: failure(.connectivity), when: {
            let clientError = NSError(domain: "Test", code: 0)
            client.complete(with: clientError)
        })
    }
    
    func test_load_deliversErrorOnNon200HTTPResponse() {
        let (sut, client) = makeSUT()
        
        let samples = [199, 201, 300, 400, 500]
        
        samples.enumerated().forEach { index, code in
            expect(sut, toCompleteWith: failure(.invalidData), when: {
                let json = makeJSONData([:])
                client.complete(withStatusCode: code, data: json, at: index)
            })
        }
    }
    
    func test_load_deliversMenuOn200HTTPResponseWithJSONMenu() {
        let (sut, client) = makeSUT()
        
        let pizzaMenu = makePizzaMenu(pizzas: [
            makePizza(
                ingredients: [1, 2, 3],
                name: "Margherita"),
            makePizza(
                ingredients: [3, 2, 1],
                name: "Ricci",
                url: URL(string: "http://another-url.com")!)
        ], basePrice: 4.0)
        
        let model = pizzaMenu.model
        
        expect(sut, toCompleteWith: .success(model), when: {
            let json = makeJSONData(pizzaMenu.json)
            client.complete(withStatusCode: 200, data: json)
        })
    }
    
    func test_load_doesNotDeliverResultAfterSUTInstanceHasBeenDeallocated() {
        let url = URL(string: "http://any-url.com")!
        let client = HTTPClientSpy()
        var sut: RemotePizzaMenuLoader? = RemotePizzaMenuLoader(url: url, client: client)
        
        var capturedResults = [RemotePizzaMenuLoader.Result]()
        sut?.load { capturedResults.append($0) }
        
        sut = nil
        client.complete(withStatusCode: 200, data: makeJSONData([:]))
        
        XCTAssertTrue(capturedResults.isEmpty)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(url: URL = URL(string: "https://any-url.com")!, file: StaticString = #file, line: UInt = #line) -> (sut: RemotePizzaMenuLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemotePizzaMenuLoader(url: url, client: client)
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(client, file: file, line: line)
        return (sut, client)
    }
    
    private func failure(_ error: RemotePizzaMenuLoader.Error) -> RemotePizzaMenuLoader.Result {
        .failure(error)
    }
    
    private func makeJSONData(_ json: [String: Any]) -> Data {
        try! JSONSerialization.data(withJSONObject: json)
    }
    
    private func makePizzaMenu(pizzas: [(model: Pizza, json: [String: Any])], basePrice: Double) -> (model: PizzaMenu, json: [String: Any]) {
        let pizzaMenu = PizzaMenu(pizzas: pizzas.map { $0.model }, basePrice: basePrice)
        
        let json = [
            "basePrice": basePrice,
            "pizzas": pizzas.map { $0.json } as Any
        ].compactMapValues({ $0 })
        
        return (pizzaMenu, json)
    }
    
    private func makePizza(ingredients: [Int], name: String, url: URL? = nil) -> (model: Pizza, json: [String: Any]) {
        let pizza = Pizza(ingredients: ingredients, name: name, url: url)
        
        let json = [
            "ingredients": ingredients,
            "name": name,
            "imageURL": url?.absoluteString as Any
        ].compactMapValues({ $0 })
        
        return (pizza, json)
    }
    
    private func expect(_ sut: RemotePizzaMenuLoader, toCompleteWith expectedResult: RemotePizzaMenuLoader.Result, when action: () -> Void, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "Wait for load completion")
        
        sut.load { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receivedItems), .success(expectedItems)):
                XCTAssertEqual(receivedItems, expectedItems, file: file, line: line)
                
            case let (.failure(receivedError as RemotePizzaMenuLoader.Error), .failure(expectedError as RemotePizzaMenuLoader.Error)):
                XCTAssertEqual(receivedError, expectedError, file: file, line: line)
                
            default:
                XCTFail("Expected result \(expectedResult) got \(receivedResult) instead", file: file, line: line)
            }
            
            exp.fulfill()
        }
        
        action()
        
        wait(for: [exp], timeout: 1.0)
    }
    
    class HTTPClientSpy: HTTPClient {
        private var messages = [(url: URL, completion: (HTTPClient.Result) -> Void)]()
        
        var requestedURLs: [URL] {
            return messages.map { $0.url }
        }
        
        func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) {
            messages.append((url, completion))
        }
        
        func complete(with error: Error, at index: Int = 0) {
            messages[index].completion(.failure(error))
        }
        
        func complete(withStatusCode code: Int, data: Data, at index: Int = 0) {
            let response = HTTPURLResponse(
                url: requestedURLs[index],
                statusCode: code,
                httpVersion: nil,
                headerFields: nil
            )!
            messages[index].completion(.success((data, response)))
        }
    }
}
