//
//  PizzaMenuPresenter.swift
//  NennoPizzaCore
//
//  Created by Vadym Bohdan on 04.07.2023.
//

import Foundation

public struct PizzaMenuViewModel {
    let pizzas: [Pizza]
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
    
    public func didFinishLoadingMenu(with pizzas: [Pizza]) {
        pizzaMenuView.display(PizzaMenuViewModel(pizzas: pizzas))
    }
}
