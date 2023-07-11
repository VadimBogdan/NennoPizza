//
//  RemotePizzaMenuAndIngredientsLoader.swift
//  NennoPizzaCore
//
//  Created by Vadym Bohdan on 05.07.2023.
//

import Foundation

public final class RemotePizzaMenuAndIngredientsLoader: PizzaMenuAndIngredientsLoader {
    public typealias Result = PizzaMenuAndIngredientsLoader.Result
    
    public enum Error: Swift.Error {
        case invalidData
    }
    
    private let remotePizzaMenuLoader: RemotePizzaMenuLoader
    private let remoteIngredientsLoader: RemoteIngredientsLoader
    private let queue = DispatchQueue(label: "com.vadymbohdan.menuAndIngredientsQueue")
    
    public init(remotePizzaMenuLoader: RemotePizzaMenuLoader, remoteIngredientsLoader: RemoteIngredientsLoader) {
        self.remotePizzaMenuLoader = remotePizzaMenuLoader
        self.remoteIngredientsLoader = remoteIngredientsLoader
    }
    
    public func load(completion: @escaping (Result) -> Void) {
        queue.async { [weak self] in
            var pizzaMenu: PizzaMenu?
            var pizzaIngredients: [Ingredient]?
            
            let group = DispatchGroup()
            
            group.enter()
            self?.remotePizzaMenuLoader.load { result in
                switch result {
                case let .success(menu):
                    pizzaMenu = menu
                case let .failure(error): completion(.failure(error))
                }
                group.leave()
            }
            
            group.enter()
            self?.remoteIngredientsLoader.load { result in
                switch result {
                case let .success(ingredients):
                    pizzaIngredients = ingredients
                case let .failure(error): completion(.failure(error))
                }
                group.leave()
            }
            
            group.wait()
            
            guard let pizzaMenu, let pizzaIngredients else { return completion(.failure(Error.invalidData)) }
            
            completion(.success((pizzaMenu, pizzaIngredients)))
        }
    }
}
