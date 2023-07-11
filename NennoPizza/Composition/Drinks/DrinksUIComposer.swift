//
//  DrinksUIComposer.swift
//  NennoPizza
//
//  Created by Vadym Bohdan on 11.07.2023.
//

import NennoPizzaCoreiOS
import NennoPizzaCore

final class DrinksUIComposer {
    
    private init() {}
    
    public static func drinksComposedWith(drinksLoader: DrinksLoader,
                                          didSelectDrink: @escaping (Drink) -> Void) -> DrinksViewController {
        let presentationAdapter = DrinksPresentationAdapter(drinksLoader: MainQueueDispatchDecorator(decoratee: drinksLoader))
        
        let drinksViewController = makeDrinksViewController(delegate: presentationAdapter,
                                                            title: DrinksPresenter.title)
        
        let adapter = DrinksViewAdapter(controller: drinksViewController,
                                        drinkSelectionCallback: { [weak presentationAdapter] in
            presentationAdapter?.didAddedToCartSubject.send()
            didSelectDrink($0)
        })
        
        let presenter = DrinksPresenter(drinksView: adapter,
                                        addedToCartView: WeakRefVirtualProxy(drinksViewController))
        
        presentationAdapter.presenter = presenter
        
        return drinksViewController
    }
    
    private static func makeDrinksViewController(delegate: DrinksViewControllerDelegate, title: String) -> DrinksViewController {
        let cartController = DrinksViewController()
        cartController.delegate = delegate
        cartController.title = title
        return cartController
    }
    
}

