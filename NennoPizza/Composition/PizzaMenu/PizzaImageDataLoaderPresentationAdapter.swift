//
//  PizzaImageDataLoaderPresentationAdapter.swift
//  NennoPizza
//
//  Created by Vadym Bohdan on 06.07.2023.
//

import NennoPizzaCore
import NennoPizzaCoreiOS

final class PizzaImageDataLoaderPresentationAdapter<View: PizzaView, Image>: PizzaCellControllerDelegate where View.Image == Image {
    private let model: Pizza
    private let imageLoader: PizzaImageDataLoader
    private let pizzaSelectionCallback: (Pizza) -> Void

    var presenter: PizzaPresenter<View, Image>?

    init(model: Pizza, imageLoader: PizzaImageDataLoader, pizzaSelectionCallback: @escaping (Pizza) -> Void) {
        self.model = model
        self.imageLoader = imageLoader
        self.pizzaSelectionCallback = pizzaSelectionCallback
    }

    func didRequestPizzaData() {
        presenter?.didStartLoadingData(for: model)

        guard let imageURL = model.url else { return }
        
        let model = self.model
        imageLoader.loadImageData(from: imageURL) { [weak self] result in
            switch result {
            case let .success(data):
                self?.presenter?.didFinishLoadingData(with: data, for: model)

            case let .failure(error):
                self?.presenter?.didFinishLoadingData(with: error, for: model)
            }
        }
    }
    
    func didSelectPizza() {
        pizzaSelectionCallback(model)
    }
    
}
