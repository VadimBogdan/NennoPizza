//
//  DrinksPresenter.swift
//  NennoPizzaCore
//
//  Created by Vadym Bohdan on 11.07.2023.
//

import Foundation

public protocol DrinksView {
    func display(_ model: DrinksViewModel)
}

public final class DrinksPresenter {
    private let drinksView: DrinksView
    private let addedToCartView: AddedToCartView
    
    private var addedToCartMessage: String {
        NSLocalizedString("DRINKS_ADDED_TO_CART_VIEW_TITLE",
                          tableName: "Drinks",
                          bundle: Bundle(for: PizzaMenuPresenter.self),
                          comment: "Message for Added To Cart view")
    }
    
    public init(drinksView: DrinksView, addedToCartView: AddedToCartView) {
        self.drinksView = drinksView
        self.addedToCartView = addedToCartView
    }
    
    public static var title: String {
        NSLocalizedString("DRINKS_VIEW_TITLE",
                          tableName: "Drinks",
                          bundle: Bundle(for: DrinksPresenter.self),
                          comment: "Title for the Drinks view")
    }
    
    public func didLoadDrinks(_ drinks: [Drink]) {
        drinksView.display(DrinksViewModel(drinks: drinks))
    }
    
    public func didStartDisplayAddedToCart() {
        addedToCartView.display(.addedToCart(message: addedToCartMessage))
    }
    
    public func didFinishDisplayAddedToCart() {
        addedToCartView.display(.notDisplayed)
    }
}
