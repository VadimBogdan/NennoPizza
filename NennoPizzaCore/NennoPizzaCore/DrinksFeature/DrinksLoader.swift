//
//  DrinksLoader.swift
//  NennoPizzaCore
//
//  Created by Vadym Bohdan on 10.07.2023.
//

import Foundation

public protocol DrinksLoader {
    typealias Result = Swift.Result<[Drink], Error>
    
    func load(completion: @escaping (Result) -> Void)
}
