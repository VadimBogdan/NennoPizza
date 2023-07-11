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
    
    private var cart = Cart.Factory.empty
    private var pizzaMenu: PizzaMenu?
    private var ingredients: [Ingredient]?
    private var pizzaPriceCalculator: PizzaPriceCalculator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let remoteCheckoutURL = URL(string: "http://httpbin.org/post")!
        let remotePizzasURL = URL(string: "https://doclerlabs.github.io/mobile-native-challenge/pizzas.json")!
        let remoteIngredientsURL = URL(string: "https://doclerlabs.github.io/mobile-native-challenge/ingredients.json")!
        let remoteDrinksURL = URL(string: "https://doclerlabs.github.io/mobile-native-challenge/drinks.json")!
        
        let httpClient = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
        
        let remotePizzaMenuLoader = RemotePizzaMenuLoader(url: remotePizzasURL, client: httpClient)
        let remoteIngredientsLoader = RemoteIngredientsLoader(url: remoteIngredientsURL, client: httpClient)
        
        let menuAndIngredientsLoader = PizzaMenuAndIngredientsLoaderWithCompletionDecorator(
            RemotePizzaMenuAndIngredientsLoader(
                remotePizzaMenuLoader: remotePizzaMenuLoader,
                remoteIngredientsLoader: remoteIngredientsLoader),
            loadResultCompletion: { [weak self] in self?.pizzaMenuAndIngredientsLoaded($0) })
        
        let remoteImageLoader = RemotePizzaImageDataLoader(client: httpClient)
        let remoteCheckoutUploader = RemoteCheckoutUploader(url: remoteCheckoutURL, client: httpClient)
        let remoteDrinksLoader = RemoteDrinksLoader(url: remoteDrinksURL, client: httpClient)
        
        let rootNavigationController = UINavigationController()
        
        let pizzaMenuViewController = PizzaMenuUIComposer.pizzaMenuComposedWith(
            menuAndIngredientsLoader: menuAndIngredientsLoader,
            imageLoader: remoteImageLoader,
            didSelectCartCallback: { [weak rootNavigationController] in
                rootNavigationController?.pushViewController(CartUIComposer.cartComposedWith(
                    cartLoader: { self.cart },
                    didSelectCheckout: {
                        let pizzaAndDrinks = (self.cart.pizzas.map(\.pizza), self.cart.drinks.map(\.id))
                        let checkoutViewController = CheckoutUIComposer.checkoutComposedWith(
                            checkoutUploader: remoteCheckoutUploader,
                            pizzasAndDrinks: pizzaAndDrinks)
                        checkoutViewController.modalPresentationStyle = .fullScreen
                        
                        rootNavigationController?.present(checkoutViewController, animated: true)
                    },
                    didSelectDrinks: {
                        let drinksViewController = DrinksUIComposer.drinksComposedWith(
                            drinksLoader: remoteDrinksLoader,
                            didSelectDrink: { self.addDrinkToCart($0) })
                        
                        rootNavigationController?.pushViewController(drinksViewController, animated: true)
                    }), animated: true)
            },
            didAddedPizzaToCart: { [weak self] in self?.addPizzaToCart($0) })
        
        rootNavigationController.pushViewController(pizzaMenuViewController, animated: true)
        window?.rootViewController = rootNavigationController
        
        window?.makeKeyAndVisible()
    }
    
    private func addPizzaToCart(_ pizza: Pizza) {
        guard let pizzaPriceCalculator else { return }
        let pizzaPrice = pizzaPriceCalculator.calculate(with: pizza.ingredients)
        cart.pizzas.append(PricedPizza(pizza: pizza, price: pizzaPrice))
    }
    
    private func addDrinkToCart(_ drink: Drink) {
        cart.drinks.append(drink)
    }
    
    private func pizzaMenuAndIngredientsLoaded(_ result: Result<(PizzaMenu, [Ingredient]), Error>) {
        guard case let .success((menu, ingredients)) = result else { return }
        pizzaPriceCalculator = PizzaPriceCalculator(basePrice: menu.basePrice, ingredients: ingredients)
        (self.pizzaMenu, self.ingredients) = (menu, ingredients)
    }
    
}

