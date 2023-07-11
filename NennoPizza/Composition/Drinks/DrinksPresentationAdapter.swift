//
//  DrinksPresentationAdapter.swift
//  NennoPizza
//
//  Created by Vadym Bohdan on 11.07.2023.
//

import NennoPizzaCoreiOS
import NennoPizzaCore

final class DrinksPresentationAdapter: DrinksViewControllerDelegate {
    
    var presenter: DrinksPresenter?
    
    private let drinksLoader: DrinksLoader
    
    init(drinksLoader: DrinksLoader) {
        self.drinksLoader = drinksLoader
    }
    
    func didRequestDrinks() {
        drinksLoader.load { [weak self] result in
            if case let .success(drinks) = result {
                self?.presenter?.didLoadDrinks(drinks)
            }
        }
    }
    
}
