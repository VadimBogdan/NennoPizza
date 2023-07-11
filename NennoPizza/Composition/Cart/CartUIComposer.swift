//
//  CartUIComposer.swift
//  NennoPizza
//
//  Created by Vadym Bohdan on 08.07.2023.
//

import NennoPizzaCoreiOS
import NennoPizzaCore
import Foundation

class CartUIComposer {
    
    private init() {}
    
    public static func cartComposedWith(cartLoader: @escaping () -> Cart,
                                        didSelectCheckout: @escaping () -> Void,
                                        didSelectDrinks: @escaping () -> Void) -> CartViewController {
        let presentationAdapter = CartPresentationAdapter(cartLoader: cartLoader,
                                                          didSelectCheckoutCallBack: didSelectCheckout,
                                                          didSelectDrinksCallBack: didSelectDrinks)
        
        let cartViewController = makeCartViewController(delegate: presentationAdapter,
                                                        title: CartPresenter.title,
                                                        checkoutTitle: CartPresenter.checkoutButtonTitle)
        
        let adapter = CartViewAdapter(controller: cartViewController)
        
        let presenter = CartPresenter(cartView: adapter,
                                      cartTotalPriceView: WeakRefVirtualProxy(adapter),
                                      priceFormatter: {
            NumberFormatter.format($0, currency: Constants.usdCurrencySymbol)
        })
        
        presentationAdapter.presenter = presenter
        
        return cartViewController
    }
    
    private static func makeCartViewController(delegate: CartViewControllerDelegate, title: String, checkoutTitle: String) -> CartViewController {
        let cartController = CartViewController()
        cartController.delegate = delegate
        cartController.checkoutButton.setTitle(checkoutTitle, for: .normal)
        cartController.title = title
        return cartController
    }
    
}
