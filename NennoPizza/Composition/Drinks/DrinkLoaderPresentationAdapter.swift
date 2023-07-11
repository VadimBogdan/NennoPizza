//
//  DrinkLoaderPresentationAdapter.swift
//  NennoPizza
//
//  Created by Vadym Bohdan on 11.07.2023.
//

import NennoPizzaCoreiOS
import NennoPizzaCore

final class DrinkLoaderPresentationAdapter: DrinkCellControllerDelegate {
    
    private let model: Drink
    private let drinkSelectionCallback: (Drink) -> Void

    var presenter: DrinkPresenter?

    init(model: Drink, drinkSelectionCallback: @escaping (Drink) -> Void) {
        self.model = model
        self.drinkSelectionCallback = drinkSelectionCallback
    }

    func didRequestDrink() {
        presenter?.didLoadDrink(model)
    }
    
    func didSelectDrink() {
        drinkSelectionCallback(model)
    }
    
}
