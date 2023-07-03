//
//  LoadIngredientsFromRemoteUseCase.swift
//  NennoPizzaCoreTests
//
//  Created by Vadym Bohdan on 03.07.2023.
//

import XCTest
import NennoPizzaCore

struct RemoteIngredient: Decodable {
    let price: Double
    let name: String
    let id: Int
}

class RemoteIngredientsLoader: IngredientsLoader {
    public typealias Result = IngredientsLoader.Result
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    private let url: URL
    private let client: HTTPClient
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    func load(completion: @escaping (Result) -> Void) {
        client.get(from: url) { [weak self] result in
            guard self != nil else { return }
            
            switch result {
            case let .success((data, response)):
                completion(RemoteIngredientsLoader.map(data, from: response))
                
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
    
    private static func map(_ data: Data, from response: HTTPURLResponse) -> Result {
        do {
            let ingredients = try IngredientsMapper.map(data, from: response)
            return .success(ingredients.toModels())
        } catch {
            return .failure(error)
        }
    }
}

extension HTTPURLResponse {
    private static var OK_200: Int { return 200 }
    
    var isOK: Bool {
        return statusCode == HTTPURLResponse.OK_200
    }
}

final class IngredientsMapper {
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> [RemoteIngredient] {
        guard response.isOK, let remotePizzaMenu = try? JSONDecoder().decode([RemoteIngredient].self, from: data) else {
            throw RemoteIngredientsLoader.Error.invalidData
        }
        
        return remotePizzaMenu
    }
}

private extension Array where Element == RemoteIngredient {
    func toModels() -> [Ingredient] {
        map { Ingredient(price: $0.price, name: $0.name, id: $0.id) }
    }
}

final class LoadIngredientsFromRemoteUseCase: XCTestCase {
    
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
                let json = makeJSONData([])
                client.complete(withStatusCode: code, data: json, at: index)
            })
        }
    }
    
    func test_load_deliversIngredientsOn200HTTPResponseWithJSONIngredients() {
        let (sut, client) = makeSUT()
        
        let ingredient1 = makeIngredient(price: 0.5, name: "Ingredient1", id: 0)
        let ingredient2 = makeIngredient(price: 2, name: "Ingredient2", id: 1)
        
        let model = [ingredient1.model, ingredient2.model]
        
        expect(sut, toCompleteWith: .success(model), when: {
            let json = makeJSONData([ingredient1.json, ingredient2.json])
            client.complete(withStatusCode: 200, data: json)
        })
    }
    
    func test_load_doesNotDeliverResultAfterSUTInstanceHasBeenDeallocated() {
        let url = URL(string: "http://any-url.com")!
        let client = HTTPClientSpy()
        var sut: RemoteIngredientsLoader? = RemoteIngredientsLoader(url: url, client: client)
        
        var capturedResults = [RemoteIngredientsLoader.Result]()
        sut?.load { capturedResults.append($0) }
        
        sut = nil
        client.complete(withStatusCode: 200, data: makeJSONData([]))
        
        XCTAssertTrue(capturedResults.isEmpty)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(url: URL = URL(string: "https://any-url.com")!, file: StaticString = #file, line: UInt = #line) -> (sut: RemoteIngredientsLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteIngredientsLoader(url: url, client: client)
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(client, file: file, line: line)
        return (sut, client)
    }
    
    private func failure(_ error: RemoteIngredientsLoader.Error) -> RemoteIngredientsLoader.Result {
        .failure(error)
    }
    
    private func makeJSONData(_ json: [[String: Any]]) -> Data {
        return try! JSONSerialization.data(withJSONObject: json)
    }
    
    private func makeIngredient(price: Double, name: String, id: Int) -> (model: Ingredient, json: [String: Any]) {
        let ingredient = Ingredient(price: price, name: name, id: id)
        
        let json = [
            "price": price,
            "name": name,
            "id": id
        ] as [String: Any]
        
        return (ingredient, json)
    }
    
    private func expect(_ sut: RemoteIngredientsLoader, toCompleteWith expectedResult: RemoteIngredientsLoader.Result, when action: () -> Void, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "Wait for load completion")
        
        sut.load { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receivedItems), .success(expectedItems)):
                XCTAssertEqual(receivedItems, expectedItems, file: file, line: line)
                
            case let (.failure(receivedError as RemoteIngredientsLoader.Error), .failure(expectedError as RemoteIngredientsLoader.Error)):
                XCTAssertEqual(receivedError, expectedError, file: file, line: line)
                
            default:
                XCTFail("Expected result \(expectedResult) got \(receivedResult) instead", file: file, line: line)
            }
            
            exp.fulfill()
        }
        
        action()
        
        wait(for: [exp], timeout: 1.0)
    }
}
