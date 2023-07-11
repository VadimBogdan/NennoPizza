//
//  Cart.swift
//  NennoPizzaCore
//
//  Created by Vadym Bohdan on 07.07.2023.
//

import Foundation

public struct CartItem {
    public let name: String
    public let price: Double
    
    public init(name: String, price: Double) {
        self.name = name
        self.price = price
    }
}
