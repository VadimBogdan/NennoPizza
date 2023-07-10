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
                                        didSelectCheckout: @escaping () -> Void) -> CartViewController {
        let presentationAdapter = CartPresentationAdapter(cartLoader: cartLoader,
                                                          didSelectCheckoutCallBack: didSelectCheckout)
        
        let cartViewController = makeCartViewController(delegate: presentationAdapter,
                                                        title: CartPresenter.title)
        
        let adapter = CartViewAdapter(controller: cartViewController)
        
        let presenter = CartPresenter(cartView: adapter,
                                      cartTotalPriceView: WeakRefVirtualProxy(adapter), priceFormatter: { NumberFormatter.format($0, currency: "$") })
        
        presentationAdapter.presenter = presenter
        
        return cartViewController
    }
    
    private static func makeCartViewController(delegate: CartViewControllerDelegate, title: String) -> CartViewController {
        let cartController = CartViewController()
        cartController.delegate = delegate
        cartController.title = title
        return cartController
    }
    
}
