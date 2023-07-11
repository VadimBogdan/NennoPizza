//
//  PizzaMenu.swift
//  NennoPizzaCore
//
//  Created by Vadym Bohdan on 03.07.2023.
//

import Foundation

public struct PizzaMenu: Equatable {
    public let pizzas: [Pizza]
    public let basePrice: Double
    
    public init(pizzas: [Pizza], basePrice: Double) {
        self.pizzas = pizzas
        self.basePrice = basePrice
    }
}

public struct Pizza: Equatable {
    public let ingredients: [Int]
    public let name: String
    public let url: URL?
    
    public init(ingredients: [Int], name: String, url: URL? = nil) {
        self.ingredients = ingredients
        self.name = name
        self.url = url
    }
}
