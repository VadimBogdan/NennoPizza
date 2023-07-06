//
//  Cart.swift
//  NennoPizza
//
//  Created by Vadym Bohdan on 06.07.2023.
//

import NennoPizzaCore

struct PricedPizza {
    let pizza: Pizza
    let price: String
}

final class Cart {
    var pizzas = [PricedPizza]()
}
