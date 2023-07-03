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
        
        return ingredients.filter({
            ingredientIds.contains($0.id)
        })
        .reduce(basePrice) { $0 + $1.price }
    }
}

final class CalculatePizzaPriceUseCase: XCTestCase {
    
    func test_calculate_returnsBasePriceWhenIngredientIdsAreEmpty() {
        let basePrice = 5.0
        let ingredients = makeRandomIngredients()
        let pizzaPriceCalculator = makeSUT(basePrice: basePrice, ingredients: ingredients)
        
        XCTAssertEqual(pizzaPriceCalculator.calculate(with: []), basePrice)
    }
    
    func test_calculate_returnsBasePriceWhenIngredientIdIsNonExistent() {
        let basePrice = 5.0
        let ingredients = makeRandomIngredients()
        let pizzaPriceCalculator = makeSUT(basePrice: basePrice, ingredients: ingredients)
        
        XCTAssertEqual(pizzaPriceCalculator.calculate(with: [-1]), basePrice)
    }
    
    func test_calculate_returnsCorrectPriceWhenIngredientIdsExists() {
        let basePrice = 5.0
        let ingredients = makeRandomIngredients()
        let pizzaPriceCalculator = makeSUT(basePrice: basePrice, ingredients: ingredients)
        
        XCTAssertEqual(pizzaPriceCalculator.calculate(with: [0, 2]),
                       basePrice + ingredients[0].price + ingredients[2].price)
    }
    
    func test_calculate_returnsCorrectPriceWhileIgnoringNonExistentIngredientIds() {
        let basePrice = 5.0
        let ingredients = makeRandomIngredients()
        let pizzaPriceCalculator = makeSUT(basePrice: basePrice, ingredients: ingredients)
        
        XCTAssertEqual(pizzaPriceCalculator.calculate(with: [-1 ,0, -1, 2]),
                       basePrice + ingredients[0].price + ingredients[2].price)
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
