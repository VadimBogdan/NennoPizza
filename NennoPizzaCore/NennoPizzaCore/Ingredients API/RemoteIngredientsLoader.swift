//
//  RemoteIngredientsLoader.swift
//  NennoPizzaCore
//
//  Created by Vadym Bohdan on 03.07.2023.
//

import Foundation

public final class RemoteIngredientsLoader: IngredientsLoader {
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
    
    public func load(completion: @escaping (Result) -> Void) {
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

private extension Array where Element == RemoteIngredient {
    func toModels() -> [Ingredient] {
        map { Ingredient(price: $0.price, name: $0.name, id: $0.id) }
    }
}
