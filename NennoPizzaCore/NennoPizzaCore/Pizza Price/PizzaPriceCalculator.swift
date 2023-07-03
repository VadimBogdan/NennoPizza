//
//  PizzaPriceCalculator.swift
//  NennoPizzaCore
//
//  Created by Vadym Bohdan on 03.07.2023.
//

import Foundation

public final class PizzaPriceCalculator {
    private let basePrice: Double
    private let ingredients: [Ingredient]
    
    public init(basePrice: Double, ingredients: [Ingredient]) {
        self.basePrice = basePrice
        self.ingredients = ingredients
    }
    
    public func calculate(with ingredientIds: [Int]) -> Double {
        guard !ingredientIds.isEmpty else { return basePrice }
        
        return ingredients.filter({
            ingredientIds.contains($0.id)
        })
        .reduce(basePrice) { $0 + $1.price }
    }
}
