//
//  PizzaMenuUIComposer.swift
//  NennoPizza
//
//  Created by Vadym Bohdan on 06.07.2023.
//

import NennoPizzaCoreiOS
import NennoPizzaCore

class PizzaMenuUIComposer {
    private init() {}
    
    public static func pizzaMenuComposedWith(menuAndIngredientsLoader: PizzaMenuAndIngredientsLoader,
                                             imageLoader: PizzaImageDataLoader,
                                             didSelectCartCallback: @escaping () -> Void,
                                             didAddedPizzaToCart: @escaping (Pizza) -> Void) -> PizzaMenuViewController {
        let presentationAdapter = PizzaMenuLoaderPresentationAdapter(
            menuAndIngredientsLoader: MainQueueDispatchDecorator(decoratee: menuAndIngredientsLoader),
            didSelectCartCallback: didSelectCartCallback)
        
        let pizzaMenuViewController = makePizzaMenuViewController(delegate: presentationAdapter,
                                                                  title: PizzaMenuPresenter.title)
        
        let presenter = PizzaMenuPresenter(
            pizzaMenuView: PizzaViewAdapter(
                controller: pizzaMenuViewController,
                currency: Constants.usdCurrencySymbol,
                imageLoader: SimplePizzaImageDataCachedLoader(loader: MainQueueDispatchDecorator(decoratee: imageLoader)),
                pizzaSelection: { [weak presentationAdapter] in
                    presentationAdapter?.didAddedToCartSubject.send()
                    didAddedPizzaToCart($0)
                }),
            addedToCartView: WeakRefVirtualProxy(pizzaMenuViewController))
        
        presentationAdapter.presenter = presenter
        
        return pizzaMenuViewController
    }
    
    private static func makePizzaMenuViewController(delegate: PizzaMenuViewControllerDelegate, title: String) -> PizzaMenuViewController {
        let pizzaMenuController = PizzaMenuViewController()
        pizzaMenuController.delegate = delegate
        pizzaMenuController.title = title
        return pizzaMenuController
    }
    
}
