//
//  SceneDelegate.swift
//  NennoPizza
//
//  Created by Vadym Bohdan on 30.06.2023.
//

import UIKit
import NennoPizzaCoreiOS
import NennoPizzaCore

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    private var cart = Cart()
    private var pizzaMenu: PizzaMenu?
    private var ingredients: [Ingredient]?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let remotePizzasURL = URL(string: "https://doclerlabs.github.io/mobile-native-challenge/pizzas.json")!
        let remoteIngredientsURL = URL(string: "https://doclerlabs.github.io/mobile-native-challenge/ingredients.json")!
        
        let httpClient = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
        
        let remotePizzaMenuLoader = RemotePizzaMenuLoader(url: remotePizzasURL, client: httpClient)
        let remoteIngredientsLoader = RemoteIngredientsLoader(url: remoteIngredientsURL, client: httpClient)
        
        let menuAndIngredientsLoader = PizzaMenuAndIngredientsLoaderWithCompletionDecorator(
            RemotePizzaMenuAndIngredientsLoader(
                remotePizzaMenuLoader: remotePizzaMenuLoader,
                remoteIngredientsLoader: remoteIngredientsLoader)) { [weak self] in
                    guard let self, case let .success((menu, ingredients)) = $0 else { return }
                    (self.pizzaMenu, self.ingredients) = (menu, ingredients)
                }
        let imageLoader = RemotePizzaImageDataLoader(client: httpClient)
        
        let rootNavigationController = UINavigationController()
        let pizzaMenuViewController = PizzaMenuUIComposer.pizzaMenuComposedWith(
            menuAndIngredientsLoader: menuAndIngredientsLoader,
            imageLoader: imageLoader,
            didSelectCartCallback: { [weak rootNavigationController] in
                rootNavigationController?.pushViewController(CartUIComposer.cartComposedWith { [weak self] in
                    guard let self else { return Cart.empty }
                    return self.cart
                } didSelectCheckout: {
                    
                }, animated: true)
            },
            didAddedPizzaToCart: { [weak self] in self?.addPizzaToCart($0) })
        
        rootNavigationController.pushViewController(pizzaMenuViewController, animated: true)
        window?.rootViewController = rootNavigationController
        
        window?.makeKeyAndVisible()
    }
    
    private func addPizzaToCart(_ pizza: Pizza) {
        guard let basePrice = pizzaMenu?.basePrice, let ingredients = ingredients else { return }
        let pizzaPrice = PizzaPriceCalculator(basePrice: basePrice, ingredients: ingredients).calculate(with: pizza.ingredients)
        cart.pizzas.append(PricedPizza(pizza: pizza, price: pizzaPrice))
    }
    
}

