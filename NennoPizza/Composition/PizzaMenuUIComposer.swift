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
                                             imageLoader: PizzaImageDataLoader) -> PizzaMenuTableViewController {
        let presentationAdapter = PizzaMenuLoaderPresentationAdapter(menuAndIngredientsLoader: MainQueueDispatchDecorator(decoratee: menuAndIngredientsLoader))
        
        let pizzaMenuTableViewController = makePizzaMenuViewController(delegate: presentationAdapter,
                                                                       title: PizzaMenuPresenter.title)
        
        let presenter = PizzaMenuPresenter(
            pizzaMenuView: PizzaViewAdapter(
                controller: pizzaMenuTableViewController,
                imageLoader: SimplePizzaImageDataCachedLoader(loader: MainQueueDispatchDecorator(decoratee: imageLoader)))
        )
        
        presentationAdapter.presenter = presenter
        
        return pizzaMenuTableViewController
    }
    
    private static func makePizzaMenuViewController(delegate: PizzaMenuViewControllerDelegate, title: String) -> PizzaMenuTableViewController {
        let pizzaMenuController = PizzaMenuTableViewController()
        pizzaMenuController.delegate = delegate
        pizzaMenuController.title = title
        return pizzaMenuController
    }
    
}
