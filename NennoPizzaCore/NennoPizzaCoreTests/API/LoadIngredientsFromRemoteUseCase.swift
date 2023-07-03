//
//  LoadIngredientsFromRemoteUseCase.swift
//  NennoPizzaCoreTests
//
//  Created by Vadym Bohdan on 03.07.2023.
//

import XCTest
import NennoPizzaCore

class RemoteIngredientsLoader {
    private let url: URL
    private let client: HTTPClient
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
}

final class LoadIngredientsFromRemoteUseCase: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        
        XCTAssertTrue(client.requestedURLs.isEmpty)
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
