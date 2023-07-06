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

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let remotePizzasURL = URL(string: "https://doclerlabs.github.io/mobile-native-challenge/pizzas.json")!
        let remoteIngredientsURL = URL(string: "https://doclerlabs.github.io/mobile-native-challenge/ingredients.json")!
        
        let httpClient = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
        
        let remotePizzaMenuLoader = RemotePizzaMenuLoader(url: remotePizzasURL, client: httpClient)
        let remoteIngredientsLoader = RemoteIngredientsLoader(url: remoteIngredientsURL, client: httpClient)
        
        let menuAndIngredientsLoader = RemotePizzaMenuAndIngredientsLoader(remotePizzaMenuLoader: remotePizzaMenuLoader, remoteIngredientsLoader: remoteIngredientsLoader)
        let imageLoader = RemotePizzaImageDataLoader(client: httpClient)
        
        window?.rootViewController = UINavigationController(
            rootViewController: PizzaMenuUIComposer.pizzaMenuComposedWith(
                    menuAndIngredientsLoader: menuAndIngredientsLoader,
                    imageLoader: imageLoader))
        
        window?.makeKeyAndVisible()
    }
    
}

