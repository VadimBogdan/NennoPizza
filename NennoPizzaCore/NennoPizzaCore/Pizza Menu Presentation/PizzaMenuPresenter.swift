//
//  PizzaMenuPresenter.swift
//  NennoPizzaCore
//
//  Created by Vadym Bohdan on 04.07.2023.
//

import Foundation

public struct PizzaMenuViewModel {
    public let pizzaMenu: PizzaMenu
    public let ingredients: [Ingredient]
}

public protocol PizzaMenuView {
    func display(_ viewModel: PizzaMenuViewModel)
}

public protocol AddedToCartView {
    
    func display(_ viewModel: AddedToCartViewModel)
}

public final class PizzaMenuPresenter {
    private let pizzaMenuView: PizzaMenuView
    private let addedToCartView: AddedToCartView
    
    private var addedToCartMessage: String {
        NSLocalizedString("PIZZA_MENU_ADDED_TO_CART_VIEW_TITLE",
                          tableName: "Menu",
                          bundle: Bundle(for: PizzaMenuPresenter.self),
                          comment: "Message for Added To Cart view")
    }
    
    public init(pizzaMenuView: PizzaMenuView, addedToCartView: AddedToCartView) {
        self.pizzaMenuView = pizzaMenuView
        self.addedToCartView = addedToCartView
    }
    
    public static var title: String {
        NSLocalizedString("PIZZA_MENU_VIEW_TITLE",
                          tableName: "Menu",
                          bundle: Bundle(for: PizzaMenuPresenter.self),
                          comment: "Title for the Pizza Menu view")
    }
    
    public func didFinishLoadingMenu(pizzaMenu: PizzaMenu, and ingredients: [Ingredient]) {
        pizzaMenuView.display(PizzaMenuViewModel(pizzaMenu: pizzaMenu, ingredients: ingredients))
    }
    
    public func didStartDisplayAddedToCart() {
        addedToCartView.display(.addedToCart(message: addedToCartMessage))
    }
    
    public func didFinishDisplayAddedToCart() {
        addedToCartView.display(.notDisplayed)
    }
}
