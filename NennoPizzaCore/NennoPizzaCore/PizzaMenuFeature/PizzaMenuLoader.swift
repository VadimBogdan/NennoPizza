//
//  PizzaMenuLoader.swift
//  NennoPizzaCore
//
//  Created by Vadym Bohdan on 03.07.2023.
//

import Foundation

public protocol PizzaMenuLoader {
    typealias Result = Swift.Result<PizzaMenu, Error>
    
    func load(completion: @escaping (Result) -> Void)
}
