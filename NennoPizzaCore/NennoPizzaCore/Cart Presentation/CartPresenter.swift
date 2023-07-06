//
//  CartPresenter.swift
//  NennoPizzaCore
//
//  Created by Vadym Bohdan on 06.07.2023.
//

import Foundation

public protocol CartView {
    func display(_ model: CartViewModel)
}

public final class CartPresenter {
    private let cartView: CartView
    
    public init(cartView: CartView) {
        self.cartView = cartView
    }
    
    public static var title: String {
        NSLocalizedString("CART_VIEW_TITLE",
                          tableName: "Cart",
                          bundle: Bundle(for: CartPresenter.self),
                          comment: "Title for the Cart view")
    }
    
    public func didLoadCart(with cartItems: [CartItem]) {
        cartView.display(CartViewModel(items: cartItems))
    }
}
