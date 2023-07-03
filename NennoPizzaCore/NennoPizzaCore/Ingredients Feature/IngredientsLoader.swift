//
//  IngredientsLoader.swift
//  NennoPizzaCore
//
//  Created by Vadym Bohdan on 03.07.2023.
//

import Foundation

public protocol IngredientsLoader {
    typealias Result = Swift.Result<[Ingredient], Error>
    
    func load(completion: @escaping (Result) -> Void)
}
