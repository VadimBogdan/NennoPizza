//
//  DrinkPresenter.swift
//  NennoPizzaCore
//
//  Created by Vadym Bohdan on 10.07.2023.
//

import Foundation

public protocol DrinkView {
    func display(_ model: DrinkViewModel)
}

public final class DrinkPresenter {
    private let drinkView: DrinkView
    private let priceFormatter: (Double) -> String
    
    public init(drinkView: DrinkView,
                priceFormatter: @escaping (Double) -> String) {
        self.drinkView = drinkView
        self.priceFormatter = priceFormatter
    }
    
    public func didLoadDrink(_ model: Drink) {
        let drinkPrice = priceFormatter(model.price)
        drinkView.display(DrinkViewModel(name: model.name, price: drinkPrice))
    }
}
