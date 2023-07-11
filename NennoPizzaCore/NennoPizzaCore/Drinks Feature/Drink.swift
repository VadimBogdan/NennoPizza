//
//  Drink.swift
//  NennoPizzaCore
//
//  Created by Vadym Bohdan on 10.07.2023.
//

import Foundation

public struct Drink: Equatable {
    public let id: Int
    public let name: String
    public let price: Double
    
    public init(id: Int, name: String, price: Double) {
        self.id = id
        self.name = name
        self.price = price
    }
}
