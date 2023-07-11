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
    private let didSelectDrinksCallBack: () -> Void
    private let cartLoader: () -> Cart
    
    init(cartLoader: @escaping () -> Cart,
         didSelectCheckoutCallBack: @escaping () -> Void,
         didSelectDrinksCallBack: @escaping () -> Void) {
        self.didSelectCheckoutCallBack = didSelectCheckoutCallBack
        self.didSelectDrinksCallBack = didSelectDrinksCallBack
        self.cartLoader = cartLoader
    }
    
    func didRequestCart() {
        let cart = cartLoader()
        
        let cartItems = [cart.pizzas.map {
            CartItem(name: $0.pizza.name, price: $0.price)
        }, cart.drinks.map {
            CartItem(name: $0.name, price: $0.price)
        }].flatMap { $0 }
        
        let totalPrice = cartItems.reduce(0, { $0 + $1.price})
        
        presenter?.didLoadCart(cartItems, totalPrice: totalPrice)
    }
    
    func didSelectCheckout() {
        didSelectCheckoutCallBack()
    }
    
    func didSelectDrinks() {
        didSelectDrinksCallBack()
    }
    
}
