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
    private weak var controller: PizzaMenuTableViewController?
    private let imageLoader: PizzaImageDataLoader
    
    init(controller: PizzaMenuTableViewController?, imageLoader: PizzaImageDataLoader) {
        self.controller = controller
        self.imageLoader = imageLoader
    }
    
    func display(_ viewModel: PizzaMenuViewModel) {
        controller?.display(viewModel.pizzaMenu.pizzas.map { model in
            let adapter = PizzaDataLoaderPresentationAdapter<WeakRefVirtualProxy<PizzaCellController>, UIImage>(model: model, imageLoader: imageLoader)
            let view = PizzaCellController(delegate: adapter)
            
            adapter.presenter = PizzaPresenter(view: WeakRefVirtualProxy(view),
                                               currency: "$",
                                               imageTransformer: UIImage.init,
                                               priceCalculator: { ingredients in
                let formatter = NumberFormatter()
                formatter.numberStyle = .decimal
                
                return formatter.string(for: PizzaPriceCalculator(basePrice: viewModel.pizzaMenu.basePrice, ingredients: viewModel.ingredients).calculate(with: ingredients)) ?? "0"
            },
                                               ingredientsFormatter: { ingredients in
                viewModel.ingredients.filter { ingredients.contains($0.id) }.map { $0.name }.joined(separator: ", ") + "."
            })
            
            return view
        })
    }
}
