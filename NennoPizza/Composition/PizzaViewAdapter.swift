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
    private let pizzaSelection: (PricedPizza) -> Void
    
    init(controller: PizzaMenuViewController?, imageLoader: PizzaImageDataLoader, pizzaSelection: @escaping (PricedPizza) -> Void) {
        self.controller = controller
        self.imageLoader = imageLoader
        self.pizzaSelection = pizzaSelection
    }
    
    func display(_ viewModel: PizzaMenuViewModel) {
        let pizzaPriceCalculator = PizzaPriceCalculator(basePrice: viewModel.pizzaMenu.basePrice, ingredients: viewModel.ingredients)
        controller?.display(viewModel.pizzaMenu.pizzas.map { model in
            let adapter = PizzaImageDataLoaderPresentationAdapter<WeakRefVirtualProxy<PizzaCellController>, UIImage>(
                model: model,
                imageLoader: imageLoader,
                pizzaSelectionCallback: { [weak self] in
                    let pricedPizza = PricedPizza(pizza: $0, price: pizzaPriceCalculator.calculate(with: $0.ingredients))
                    self?.pizzaSelection(pricedPizza)
                })
            
            let view = PizzaCellController(delegate: adapter)
            
            adapter.presenter = PizzaPresenter(view: WeakRefVirtualProxy(view),
                                               currency: "$",
                                               imageTransformer: UIImage.init,
                                               priceCalculator: { ingredients in
                let formatter = NumberFormatter()
                formatter.numberStyle = .decimal
                
                return formatter.string(for: pizzaPriceCalculator.calculate(with: ingredients)) ?? "0"
            },
                                               ingredientsFormatter: { ingredients in
                viewModel.ingredients.filter { ingredients.contains($0.id) }.map { $0.name }.joined(separator: ", ") + "."
            })
            
            return view
        })
    }
    
}
