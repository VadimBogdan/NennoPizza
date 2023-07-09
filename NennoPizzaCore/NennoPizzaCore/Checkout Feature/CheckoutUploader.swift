//
//  CheckoutUploader.swift
//  NennoPizzaCore
//
//  Created by Vadym Bohdan on 09.07.2023.
//

import Foundation

public protocol CheckoutUploader {
    typealias Result = Swift.Result<Void, Error>
    
    func upload(pizzas: [Pizza], drinkIds: [Int], completion: @escaping (Result) -> Void)
}
