//
//  Cart.swift
//  NennoPizza
//
//  Created by Vadym Bohdan on 06.07.2023.
//

import NennoPizzaCore

struct PricedPizza {
    let pizza: Pizza
    let price: Double
}

final class Cart {
    var pizzas = [PricedPizza]()
}

extension Cart {
    
    enum Factory {
        static var empty: Cart {
            Cart()
        }
    }
    
}
