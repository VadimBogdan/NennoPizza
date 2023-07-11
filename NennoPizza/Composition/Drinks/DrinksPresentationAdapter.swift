//
//  DrinksPresentationAdapter.swift
//  NennoPizza
//
//  Created by Vadym Bohdan on 11.07.2023.
//

import NennoPizzaCoreiOS
import NennoPizzaCore
import Combine
import Foundation

final class DrinksPresentationAdapter: DrinksViewControllerDelegate {
    
    var presenter: DrinksPresenter?
    
    let didAddedToCartSubject = PassthroughSubject<Void, Never>()
    
    private let drinksLoader: DrinksLoader
    private var didAddedToCartCancellable: AnyCancellable?
    
    init(drinksLoader: DrinksLoader) {
        self.drinksLoader = drinksLoader
        self.didAddedToCartCancellable = bindAddedToCartEventsHandler()
    }
    
    func didRequestDrinks() {
        drinksLoader.load { [weak self] result in
            if case let .success(drinks) = result {
                self?.presenter?.didLoadDrinks(drinks)
            }
        }
    }
    
    private func bindAddedToCartEventsHandler() -> AnyCancellable {
        didAddedToCartSubject.map { [weak self] in
            self?.presenter?.didStartDisplayAddedToCart()
        }
        .debounce(for: RunLoop.SchedulerTimeType.Stride(Constants.addedToCartViewDuration),
                  scheduler: RunLoop.main)
        .sink { [weak self] _ in
            self?.presenter?.didFinishDisplayAddedToCart()
        }
    }
    
}
