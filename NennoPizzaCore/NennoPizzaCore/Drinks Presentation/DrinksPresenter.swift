//
//  DrinksPresenter.swift
//  NennoPizzaCore
//
//  Created by Vadym Bohdan on 11.07.2023.
//

import Foundation

public protocol DrinksView {
    func display(_ model: DrinksViewModel)
}

public final class DrinksPresenter {
    private let drinksView: DrinksView
    
    public init(drinksView: DrinksView) {
        self.drinksView = drinksView
    }
    
    public static var title: String {
        NSLocalizedString("DRINKS_VIEW_TITLE",
                          tableName: "Drinks",
                          bundle: Bundle(for: DrinksPresenter.self),
                          comment: "Title for the Drinks view")
    }
    
    public func didLoadDrinks(_ drinks: [Drink]) {
        drinksView.display(DrinksViewModel(drinks: drinks))
    }
}
