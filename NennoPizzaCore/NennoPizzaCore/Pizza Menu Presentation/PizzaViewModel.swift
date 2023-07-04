//
//  PizzaViewModel.swift
//  NennoPizzaCore
//
//  Created by Vadym Bohdan on 04.07.2023.
//

import Foundation

public struct PizzaViewModel<Image> {
    public let name: String
    public let ingredients: String
    public let price: String
    public let image: Image?
}
