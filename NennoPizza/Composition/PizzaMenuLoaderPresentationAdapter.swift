//
//  PizzaMenuLoaderPresentationAdapter.swift
//  NennoPizza
//
//  Created by Vadym Bohdan on 06.07.2023.
//

import NennoPizzaCore
import NennoPizzaCoreiOS

final class PizzaMenuLoaderPresentationAdapter: PizzaMenuViewControllerDelegate {
    private let menuAndIngredientsLoader: PizzaMenuAndIngredientsLoader
    var presenter: PizzaMenuPresenter?
    
    init(menuAndIngredientsLoader: PizzaMenuAndIngredientsLoader) {
        self.menuAndIngredientsLoader = menuAndIngredientsLoader
    }
    
    func didRequestMenu() {
        menuAndIngredientsLoader.load { [weak self] result in
            if case let .success((menu, ingredients)) = result {
                self?.presenter?.didFinishLoadingMenu(pizzaMenu: menu, and: ingredients)
            }
        }
    }
}
