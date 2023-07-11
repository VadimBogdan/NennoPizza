//
//  Ingredient.swift
//  NennoPizzaCore
//
//  Created by Vadym Bohdan on 03.07.2023.
//

import Foundation

public struct Ingredient: Equatable {
    public let price: Double
    public let name: String
    public let id: Int
    
    public init(price: Double, name: String, id: Int) {
        self.price = price
        self.name = name
        self.id = id
    }
}
