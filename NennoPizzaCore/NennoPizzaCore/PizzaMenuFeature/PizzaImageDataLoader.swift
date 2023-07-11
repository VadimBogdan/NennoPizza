//
//  PizzaImageDataLoader.swift
//  NennoPizzaCore
//
//  Created by Vadym Bohdan on 05.07.2023.
//

import Foundation

public protocol PizzaImageDataLoader {
    typealias Result = Swift.Result<Data, Error>
    
    func loadImageData(from url: URL, completion: @escaping (Result) -> Void)
}
