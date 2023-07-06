//
//  RemotePizzaMenu.swift
//  NennoPizzaCore
//
//  Created by Vadym Bohdan on 03.07.2023.
//

import Foundation

struct RemotePizzaMenu: Decodable {
    let pizzas: [RemotePizza]
    let basePrice: Double
}

struct RemotePizza: Decodable {
    let ingredients: [Int]
    let name: String
    let imageUrl: URL?
}
