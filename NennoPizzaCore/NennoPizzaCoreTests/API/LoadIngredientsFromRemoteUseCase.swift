//
//  LoadIngredientsFromRemoteUseCase.swift
//  NennoPizzaCoreTests
//
//  Created by Vadym Bohdan on 03.07.2023.
//

import XCTest
import NennoPizzaCore

struct Ingredient: Equatable {
    let price: Double
    let name: String
    let id: Int
}

protocol IngredientsLoader {
    typealias Result = Swift.Result<[Ingredient], Error>
    
    func load(completion: @escaping (Result) -> Void)
}

class RemoteIngredientsLoader: IngredientsLoader {
    private let url: URL
    private let client: HTTPClient
    
    public typealias Result = IngredientsLoader.Result
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    func load(completion: @escaping (Result) -> Void) {
        client.get(from: url) { [weak self] result in
            guard self != nil else { return }
        }
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
    
    // MARK: - Helpers
    
    private func makeSUT(url: URL = URL(string: "https://any-url.com")!, file: StaticString = #file, line: UInt = #line) -> (sut: RemoteIngredientsLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteIngredientsLoader(url: url, client: client)
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(client, file: file, line: line)
        return (sut, client)
    }
    
}
