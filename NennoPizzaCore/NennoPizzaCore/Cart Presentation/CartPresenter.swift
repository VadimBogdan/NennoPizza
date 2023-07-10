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

public protocol CartTotalPriceView {
    func display(_ model: CartTotalPriceViewModel)
}

public final class CartPresenter {
    private let cartView: CartView
    private let cartTotalPriceView: CartTotalPriceView
    private let priceFormatter: (Double) -> String
    
    public init(cartView: CartView,
                cartTotalPriceView: CartTotalPriceView,
                priceFormatter: @escaping (Double) -> String) {
        self.cartView = cartView
        self.cartTotalPriceView = cartTotalPriceView
        self.priceFormatter = priceFormatter
    }
    
    public static var title: String {
        NSLocalizedString("CART_VIEW_TITLE",
                          tableName: "Cart",
                          bundle: Bundle(for: CartPresenter.self),
                          comment: "Title for the Cart view")
    }
    
    public static var checkoutButtonTitle: String {
        NSLocalizedString("CART_CHECKOUT_TITLE",
                          tableName: "Cart",
                          bundle: Bundle(for: CartPresenter.self),
                          comment: "Title for the Checkout button")
    }

    private var cartTotalTitle: String {
        NSLocalizedString("CART_VIEW_TOTAL_PRICE_TITLE",
                          tableName: "Cart",
                          bundle: Bundle(for: CartPresenter.self),
                          comment: "Cart view total")
    }
    
    public func didLoadCart(_ cartItems: [CartItem], totalPrice: Double) {
        let totalPriceString = priceFormatter(totalPrice)
        cartView.display(CartViewModel(items: cartItems))
        cartTotalPriceView.display(CartTotalPriceViewModel(title: cartTotalTitle, price: totalPriceString))

    }
}
