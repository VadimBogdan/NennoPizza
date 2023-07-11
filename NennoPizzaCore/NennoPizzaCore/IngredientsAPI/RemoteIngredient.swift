//
//  RemoteIngredient.swift
//  NennoPizzaCore
//
//  Created by Vadym Bohdan on 03.07.2023.
//

import Foundation

struct RemoteIngredient: Decodable {
    let price: Double
    let name: String
    let id: Int
}
