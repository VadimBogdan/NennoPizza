//
//  RemotePizzaImageDataLoader.swift
//  NennoPizzaCore
//
//  Created by Vadym Bohdan on 05.07.2023.
//

import Foundation

public final class RemotePizzaImageDataLoader: PizzaImageDataLoader {
    private let client: HTTPClient
    
    public init(client: HTTPClient) {
        self.client = client
    }
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public func loadImageData(from url: URL, completion: @escaping (PizzaImageDataLoader.Result) -> Void) {
        client.get(from: url) { [weak self] result in
            guard self != nil else { return }
            
            completion(result.mapError { _ in Error.connectivity }
                .flatMap { (data, response) in
                    let isValidResponse = response.isOK && !data.isEmpty
                    return isValidResponse ? .success(data) : .failure(Error.invalidData)
                })
        }
    }
}
