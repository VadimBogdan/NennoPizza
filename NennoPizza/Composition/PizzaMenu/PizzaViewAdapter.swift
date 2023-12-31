//
//  PizzaViewAdapter.swift
//  NennoPizza
//
//  Created by Vadym Bohdan on 06.07.2023.
//

import UIKit
import NennoPizzaCore
import NennoPizzaCoreiOS

final class PizzaViewAdapter: PizzaMenuView {
    private weak var controller: PizzaMenuViewController?
    private let imageLoader: PizzaImageDataLoader
    private let currency: String
    private let pizzaSelection: (Pizza) -> Void
    
    init(controller: PizzaMenuViewController?, currency: String, imageLoader: PizzaImageDataLoader, pizzaSelection: @escaping (Pizza) -> Void) {
        self.controller = controller
        self.imageLoader = imageLoader
        self.pizzaSelection = pizzaSelection
        self.currency = currency
    }
    
    func display(_ viewModel: PizzaMenuViewModel) {
        let pizzaPriceCalculator = PizzaPriceCalculator(basePrice: viewModel.pizzaMenu.basePrice, ingredients: viewModel.ingredients)
        controller?.display(viewModel.pizzaMenu.pizzas.map { model in
            let adapter = PizzaImageDataLoaderPresentationAdapter<WeakRefVirtualProxy<PizzaCellController>, UIImage>(
                model: model,
                imageLoader: imageLoader,
                pizzaSelectionCallback: { [weak self] in
                    self?.pizzaSelection($0)
                })
            
            let view = PizzaCellController(delegate: adapter)
            
            adapter.presenter = PizzaPresenter(view: WeakRefVirtualProxy(view),
                                               imageTransformer: UIImage.init,
                                               priceCalculator: { [currency] ingredients in
                let price = pizzaPriceCalculator.calculate(with: ingredients)
                return NumberFormatter.format(price, currency: currency)
            },
                                               ingredientsFormatter: { ingredients in
                viewModel.ingredients.filter { ingredients.contains($0.id) }.map { $0.name }.joined(separator: ", ") + "."
            })
            
            return view
        })
    }
    
}
