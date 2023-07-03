//
//  HTTPClient.swift
//  NennoPizzaCore
//
//  Created by Vadym Bohdan on 03.07.2023.
//

import Foundation

public protocol HTTPClient {
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>
    
    func get(from url: URL, completion: @escaping (Result) -> Void)
}
