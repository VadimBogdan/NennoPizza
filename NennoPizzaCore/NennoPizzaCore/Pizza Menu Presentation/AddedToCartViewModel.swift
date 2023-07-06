//
//  AddedToCartViewModel.swift
//  NennoPizzaCore
//
//  Created by Vadym Bohdan on 06.07.2023.
//

import Foundation

public struct AddedToCartViewModel {
    public let message: String?
    
    static var notDisplayed: AddedToCartViewModel {
        return AddedToCartViewModel(message: nil)
    }
    
    static func addedToCart(message: String) -> AddedToCartViewModel {
        return AddedToCartViewModel(message: message)
    }
}
