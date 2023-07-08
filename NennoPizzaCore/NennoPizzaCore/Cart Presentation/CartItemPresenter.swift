//
//  CartItemPresenter.swift
//  NennoPizzaCore
//
//  Created by Vadym Bohdan on 06.07.2023.
//

import Foundation

public protocol CartItemView {
    func display(_ model: CartItemViewModel)
}

public final class CartItemPresenter {
    private let cartItemView: CartItemView
    private let priceFormatter: (Double) -> String
    
    public init(cartItemView: CartItemView,
                priceFormatter: @escaping (Double) -> String) {
        self.cartItemView = cartItemView
        self.priceFormatter = priceFormatter
    }
    
    public func didLoad(model: CartItem) {
        let itemPrice = priceFormatter(model.price)
        cartItemView.display(CartItemViewModel(name: model.name, price: itemPrice))
    }
}
