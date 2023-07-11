//
//  PizzaMenuAndIngredientsLoaderWithCompletionDecorator.swift
//  NennoPizzaCore
//
//  Created by Vadym Bohdan on 09.07.2023.
//

import Foundation

public final class PizzaMenuAndIngredientsLoaderWithCompletionDecorator: PizzaMenuAndIngredientsLoader {
    
    private let decoratee: PizzaMenuAndIngredientsLoader
    private let loadResultCompletion: (PizzaMenuAndIngredientsLoader.Result) -> Void
    
    public init(_ decoratee: PizzaMenuAndIngredientsLoader, loadResultCompletion: @escaping (PizzaMenuAndIngredientsLoader.Result) -> Void) {
        self.decoratee = decoratee
        self.loadResultCompletion = loadResultCompletion
    }
    
    public func load(completion: @escaping (PizzaMenuAndIngredientsLoader.Result) -> Void) {
        decoratee.load { [weak self] in
            self?.loadResultCompletion($0)
            completion($0)
        }
    }
    
}
