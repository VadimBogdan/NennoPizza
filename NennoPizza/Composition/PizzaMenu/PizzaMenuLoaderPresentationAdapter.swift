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
    
    var presenter: PizzaMenuPresenter?
    
    let didAddedToCartSubject = PassthroughSubject<Void, Never>()
    
    private let menuAndIngredientsLoader: PizzaMenuAndIngredientsLoader
    private var didAddedToCartCancellable: AnyCancellable?
    private let didSelectCartCallback: () -> Void
    
    init(menuAndIngredientsLoader: PizzaMenuAndIngredientsLoader,
         didSelectCartCallback: @escaping () -> Void) {
        self.menuAndIngredientsLoader = menuAndIngredientsLoader
        self.didSelectCartCallback = didSelectCartCallback
        self.didAddedToCartCancellable = bindAddedToCartEventsHandler()
    }
    
    func didRequestMenu() {
        menuAndIngredientsLoader.load { [weak self] result in
            if case let .success((menu, ingredients)) = result {
                self?.presenter?.didFinishLoadingMenu(pizzaMenu: menu, and: ingredients)
            }
        }
    }
    
    func didSelectCart() {
        didSelectCartCallback()
    }
    
    private func bindAddedToCartEventsHandler() -> AnyCancellable {
        didAddedToCartSubject.map { [weak self] in
            self?.presenter?.didStartDisplayAddedToCart()
        }
        .debounce(for: 3.0, scheduler: RunLoop.main)
        .sink { [weak self] _ in
            self?.presenter?.didFinishDisplayAddedToCart()
        }
    }
    
}
