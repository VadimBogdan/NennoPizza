//
//  DrinksViewAdapter.swift
//  NennoPizza
//
//  Created by Vadym Bohdan on 11.07.2023.
//

import Foundation
import NennoPizzaCoreiOS
import NennoPizzaCore

final class DrinksViewAdapter: DrinksView {
    
    private weak var controller: DrinksViewController?
    private let drinkSelectionCallback: (Drink) -> Void
    
    init(controller: DrinksViewController?, drinkSelectionCallback: @escaping (Drink) -> Void) {
        self.controller = controller
        self.drinkSelectionCallback = drinkSelectionCallback
    }
    
    func display(_ viewModel: DrinksViewModel) {
        controller?.display(viewModel.drinks.map({ model in
            let adapter = DrinkLoaderPresentationAdapter(model: model, drinkSelectionCallback: drinkSelectionCallback)
            let view = DrinkCellController(delegate: adapter)
            
            let presenter = DrinkPresenter(drinkView: WeakRefVirtualProxy(view), priceFormatter: {
                NumberFormatter.format($0, currency: "$")
            })
            
            adapter.presenter = presenter
            
            return view
        }))
    }
    
}
