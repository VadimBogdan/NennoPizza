//
//  CartPresentationAdapter.swift
//  NennoPizza
//
//  Created by Vadym Bohdan on 08.07.2023.
//

import NennoPizzaCore
import NennoPizzaCoreiOS

final class CartPresentationAdapter: CartViewControllerDelegate {
    
    var presenter: CartPresenter?
    
    private let didSelectCheckoutCallBack: () -> Void
    private let cartLoader: () -> Cart
    
    init(cartLoader: @escaping () -> Cart, didSelectCheckoutCallBack: @escaping () -> Void) {
        self.didSelectCheckoutCallBack = didSelectCheckoutCallBack
        self.cartLoader = cartLoader
    }
    
    func didRequestCart() {
        let cart = cartLoader()
        presenter?.didLoadCart(cart.pizzas.map {
            CartItem(name: $0.pizza.name, price: $0.price)
        }, totalPrice: cart.pizzas.reduce(0, { $0 + $1.price }))
        
    }
    
    func didSelectCheckout() {
        didSelectCheckoutCallBack()
    }
    
}
