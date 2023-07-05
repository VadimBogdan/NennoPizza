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

public final class PizzaMenuPresenter {
    private let pizzaMenuView: PizzaMenuView
    
    public init(pizzaMenuView: PizzaMenuView) {
        self.pizzaMenuView = pizzaMenuView
    }
    
    public static var title: String {
        return NSLocalizedString("PIZZA_MENU_VIEW_TITLE",
                                 tableName: "Menu",
                                 bundle: Bundle(for: PizzaMenuPresenter.self),
                                 comment: "Title for the Pizza Menu view")
    }
    
    public func didFinishLoadingMenu(pizzaMenu: PizzaMenu, and ingredients: [Ingredient]) {
        pizzaMenuView.display(PizzaMenuViewModel(pizzaMenu: pizzaMenu, ingredients: ingredients))
    }
}
