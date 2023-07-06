//
//  PizzaMenuLoaderPresentationAdapter.swift
//  NennoPizza
//
//  Created by Vadym Bohdan on 06.07.2023.
//

import Foundation
import Combine
import NennoPizzaCore
import NennoPizzaCoreiOS

final class PizzaMenuLoaderPresentationAdapter: PizzaMenuViewControllerDelegate {
    
    let didAddedToCartSubject = PassthroughSubject<Void, Never>()
    var presenter: PizzaMenuPresenter?
    
    private let menuAndIngredientsLoader: PizzaMenuAndIngredientsLoader
    private var didAddedToCartCancellable: AnyCancellable?
    
    init(menuAndIngredientsLoader: PizzaMenuAndIngredientsLoader) {
        self.menuAndIngredientsLoader = menuAndIngredientsLoader
        
        didAddedToCartCancellable = didAddedToCartSubject.map { [weak self] in
            self?.presenter?.didStartDisplayAddedToCart()
        }
        .debounce(for: 3.0, scheduler: RunLoop.main)
        .sink { [weak self] _ in
            self?.presenter?.didFinishDisplayAddedToCart()
        }
    }
    
    func didRequestMenu() {
        menuAndIngredientsLoader.load { [weak self] result in
            if case let .success((menu, ingredients)) = result {
                self?.presenter?.didFinishLoadingMenu(pizzaMenu: menu, and: ingredients)
            }
        }
    }
    
}
