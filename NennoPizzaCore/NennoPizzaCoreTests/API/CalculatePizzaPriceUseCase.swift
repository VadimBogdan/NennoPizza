//
//  CalculatePizzaPriceUseCase.swift
//  NennoPizzaCoreTests
//
//  Created by Vadym Bohdan on 03.07.2023.
//

import XCTest
import NennoPizzaCore

final class PizzaPriceCalculator {
    let basePrice: Double
    let ingredients: [Ingredient]
    
    init(basePrice: Double, ingredients: [Ingredient]) {
        self.basePrice = basePrice
        self.ingredients = ingredients
    }
    
    func calculate(with ingredientIds: [Int]) -> Double {
        guard !ingredientIds.isEmpty else { return basePrice }
        fatalError()
    }
}

final class CalculatePizzaPriceUseCase: XCTestCase {
    
    func test_calculate_returnsBasePriceWhenIngredientIdsAreEmpty() {
        let basePrice = 5.0
        let ingredients = makeRandomIngredients()
        let pizzaPriceCalculator = makeSUT(basePrice: basePrice, ingredients: ingredients)
        
        XCTAssertEqual(pizzaPriceCalculator.calculate(with: []), basePrice)
    }
    
    private func makeSUT(basePrice: Double, ingredients: [Ingredient]) -> PizzaPriceCalculator {
        PizzaPriceCalculator(basePrice: basePrice, ingredients: ingredients)
    }
    
    private func makeRandomIngredients() -> [Ingredient] {
        [Ingredient(price: 10, name: "1", id: 0),
         Ingredient(price: 5, name: "2", id: 1),
         Ingredient(price: 0.5, name: "3", id: 2)]
    }
}
