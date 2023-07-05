//
//  PizzaPresenter.swift
//  NennoPizzaCore
//
//  Created by Vadym Bohdan on 04.07.2023.
//

import Foundation

public protocol PizzaView {
    associatedtype Image
    
    func display(_ model: PizzaViewModel<Image>)
}

public final class PizzaPresenter<View: PizzaView, Image> where View.Image == Image {
    private let view: View
    private let currency: String
    private let imageTransformer: (Data) -> Image?
    private let priceCalculator: ([Int]) -> String
    private let ingredientsFormatter: ([Int]) -> String
    
    public init(view: View,
                currency: String,
                imageTransformer: @escaping (Data) -> Image?,
                priceCalculator: @escaping ([Int]) -> String,
                ingredientsFormatter: @escaping ([Int]) -> String) {
        self.view = view
        self.currency = currency
        self.ingredientsFormatter = ingredientsFormatter
        self.imageTransformer = imageTransformer
        self.priceCalculator = priceCalculator
    }
    
    public func didStartLoadingImageData(for model: Pizza) {
        let price = currency + priceCalculator(model.ingredients)
        let ingredients = ingredientsFormatter(model.ingredients)
        view.display(PizzaViewModel(name: model.name,
                                    ingredients: ingredients,
                                    price: price,
                                    image: nil))
    }
    
    public func didFinishLoadingImageData(with data: Data, for model: Pizza) {
        let image = imageTransformer(data)
        let price = currency + priceCalculator(model.ingredients)
        let ingredients = ingredientsFormatter(model.ingredients)
        view.display(PizzaViewModel(name: model.name,
                                    ingredients: ingredients,
                                    price: price,
                                    image: image))
    }
    
    public func didFinishLoadingImageData(with error: Error, for model: Pizza) {
        let price = currency + priceCalculator(model.ingredients)
        let ingredients = ingredientsFormatter(model.ingredients)
        view.display(PizzaViewModel(name: model.name,
                                    ingredients: ingredients,
                                    price: price,
                                    image: nil))
    }
}
