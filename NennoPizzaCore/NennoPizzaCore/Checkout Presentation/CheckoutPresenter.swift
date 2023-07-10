//
//  CheckoutPresenter.swift
//  NennoPizzaCore
//
//  Created by Vadym Bohdan on 10.07.2023.
//

import Foundation

public protocol CheckoutView {
    func display(_ model: CheckoutViewModel)
}

public final class CheckoutPresenter {
    
    private let checkoutView: CheckoutView
    
    public init(checkoutView: CheckoutView) {
        self.checkoutView = checkoutView
    }
    
    private var checkoutMessage: String {
        NSLocalizedString("CHECKOUT_VIEW_MESSAGE",
                          tableName: "Checkout",
                          bundle: Bundle(for: CheckoutPresenter.self),
                          comment: "Message for the Checkout View")
    }
    
    private var checkoutUploadingMessage: String {
        "..."
    }
    
    public func didStartUploadCheckout() {
        checkoutView.display(CheckoutViewModel(checkoutMessage: checkoutUploadingMessage))
    }
    
    public func didFinishUploadCheckout() {
        checkoutView.display(CheckoutViewModel(checkoutMessage: checkoutMessage))
    }
    
}
