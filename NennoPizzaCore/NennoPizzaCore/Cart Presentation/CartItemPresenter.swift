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
    
    public init(cartItemView: CartItemView) {
        self.cartItemView = cartItemView
    }
    
    public func didLoad(model: CartItem) {
        cartItemView.display(CartItemViewModel(name: model.name, price: model.price))
    }
}
