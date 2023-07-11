//
//  RemoteDrinksLoader.swift
//  NennoPizzaCore
//
//  Created by Vadym Bohdan on 11.07.2023.
//

import Foundation

public final class RemoteDrinksLoader: DrinksLoader {
    public typealias Result = DrinksLoader.Result
    
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
    
    public func load(completion: @escaping (Result) -> Void) {
        client.get(from: url) { [weak self] result in
            guard self != nil else { return }
            
            switch result {
            case let .success((data, response)):
                completion(RemoteDrinksLoader.map(data, from: response))
                
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
    
    private static func map(_ data: Data, from response: HTTPURLResponse) -> Result {
        do {
            let drinks = try DrinksMapper.map(data, from: response)
            return .success(drinks.toModels())
        } catch {
            return .failure(error)
        }
    }
}

private extension Array where Element == RemoteDrink {
    func toModels() -> [Drink] {
        map { Drink(id: $0.id, name: $0.name, price: $0.price) }
    }
}

