//
//  CartItemDataLoaderPresentationAdapter.swift
//  NennoPizza
//
//  Created by Vadym Bohdan on 08.07.2023.
//

import NennoPizzaCore
import NennoPizzaCoreiOS

final class CartItemDataLoaderPresentationAdapter: CartItemCellControllerDelegate {
    
    private let model: CartItem

    var presenter: CartItemPresenter?

    init(model: CartItem) {
        self.model = model
    }

    func didRequestCartItem() {
        presenter?.didLoad(model: model)
    }
    
}
