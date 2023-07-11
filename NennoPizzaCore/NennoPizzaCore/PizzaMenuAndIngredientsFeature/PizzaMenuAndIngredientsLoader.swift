//
//  PizzaMenuAndIngredientsLoader.swift
//  NennoPizzaCore
//
//  Created by Vadym Bohdan on 05.07.2023.
//

import Foundation

public protocol PizzaMenuAndIngredientsLoader {
    typealias Result = Swift.Result<(PizzaMenu, [Ingredient]), Error>
    
    func load(completion: @escaping (Result) -> Void)
}
