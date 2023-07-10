//
//  CheckoutUIComposer.swift
//  NennoPizza
//
//  Created by Vadym Bohdan on 10.07.2023.
//

import NennoPizzaCore
import NennoPizzaCoreiOS

class CheckoutUIComposer {
    
    private init() {}
    
    public static func checkoutComposedWith(checkoutUploader: CheckoutUploader,
                                            pizzasAndDrinks: ([Pizza], [Int])) -> CheckoutViewController {
        let presentationAdapter = CheckoutPresentationAdapter(checkoutUploader: MainQueueDispatchDecorator(decoratee: checkoutUploader),
                                                              pizzasAndDrinks: pizzasAndDrinks)
        
        let checkoutViewController = makeCheckoutViewController(delegate: presentationAdapter,
                                                                title: CartPresenter.title)
        
        let presenter = CheckoutPresenter(checkoutView: WeakRefVirtualProxy(checkoutViewController))
        
        presentationAdapter.presenter = presenter
        
        return checkoutViewController
    }
    
    private static func makeCheckoutViewController(delegate: CheckoutViewControllerDelegate, title: String) -> CheckoutViewController {
        let checkoutController = CheckoutViewController()
        checkoutController.delegate = delegate
        checkoutController.title = title
        return checkoutController
    }
    
}
