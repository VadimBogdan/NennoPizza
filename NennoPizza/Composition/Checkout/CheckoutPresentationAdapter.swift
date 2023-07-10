//
//  CheckoutPresentationAdapter.swift
//  NennoPizza
//
//  Created by Vadym Bohdan on 10.07.2023.
//

import NennoPizzaCore
import NennoPizzaCoreiOS

final class CheckoutPresentationAdapter: CheckoutViewControllerDelegate {
    
    var presenter: CheckoutPresenter?
    
    private let checkoutUploader: CheckoutUploader
    private let pizzasAndDrinks: ([Pizza], [Int])
    
    init(checkoutUploader: CheckoutUploader, pizzasAndDrinks: ([Pizza], [Int])) {
        self.checkoutUploader = checkoutUploader
        self.pizzasAndDrinks = pizzasAndDrinks
    }
    
    func didRequestCheckout() {
        presenter?.didStartUploadCheckout()
        
        checkoutUploader.upload(pizzas: pizzasAndDrinks.0, drinkIds: pizzasAndDrinks.1) { [weak self] result in
            self?.presenter?.didFinishUploadCheckout()
        }
    }
    
}
