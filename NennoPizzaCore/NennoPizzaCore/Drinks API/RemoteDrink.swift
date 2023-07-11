//
//  RemoteDrink.swift
//  NennoPizzaCore
//
//  Created by Vadym Bohdan on 11.07.2023.
//

import Foundation

struct RemoteDrink: Decodable {
    let id: Int
    let name: String
    let price: Double
    
    init(id: Int, name: String, price: Double) {
        self.id = id
        self.name = name
        self.price = price
    }
}
