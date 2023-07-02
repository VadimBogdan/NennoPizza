//
//  LoadPizzaMenuFromRemoteUseCaseTests.swift
//  NennoPizzaCoreTests
//
//  Created by Vadym Bohdan on 02.07.2023.
//

import XCTest
import NennoPizzaCore

struct PizzaMenu {
    let pizzas: [Pizza]
    let basePrice: Double
}

struct Pizza {
}

protocol HTTPClient {
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>
    
    func get(from url: URL, completion: @escaping (Result) -> Void)
}

protocol PizzaMenuLoader {
    typealias Result = Swift.Result<PizzaMenu, Error>
    
    func load(completion: @escaping (Result) -> Void)
}

class RemotePizzaMenuLoader: PizzaMenuLoader {
    typealias Result = PizzaMenuLoader.Result
    
    init(url: URL, client: HTTPClient) {
        
    }
    
    func load(completion: @escaping (Result) -> Void) {}
}

final class LoadPizzaMenuFromRemoteUseCaseTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(url: URL = URL(string: "https://any-url.com")!) -> (sut: RemotePizzaMenuLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemotePizzaMenuLoader(url: url, client: client)
        return (sut, client)
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
