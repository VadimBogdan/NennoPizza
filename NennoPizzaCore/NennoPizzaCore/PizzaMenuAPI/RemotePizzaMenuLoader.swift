//
//  RemotePizzaMenuLoader.swift
//  NennoPizzaCore
//
//  Created by Vadym Bohdan on 03.07.2023.
//

import Foundation

public final class RemotePizzaMenuLoader: PizzaMenuLoader {
    public typealias Result = PizzaMenuLoader.Result
    
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
                completion(RemotePizzaMenuLoader.map(data, from: response))
                
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
    
    private static func map(_ data: Data, from response: HTTPURLResponse) -> Result {
        do {
            let pizzaMenu = try PizzaMenuMapper.map(data, from: response)
            return .success(pizzaMenu.toModel())
        } catch {
            return .failure(error)
        }
    }
}

private extension RemotePizzaMenu {
    func toModel() -> PizzaMenu {
        PizzaMenu(pizzas: pizzas.toModels(), basePrice: basePrice)
    }
}

private extension Array where Element == RemotePizza {
    func toModels() -> [Pizza] {
        map { Pizza(ingredients: $0.ingredients, name: $0.name, url: $0.imageUrl) }
    }
}
