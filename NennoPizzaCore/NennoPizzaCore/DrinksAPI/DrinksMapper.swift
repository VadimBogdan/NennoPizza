//
//  DrinksMapper.swift
//  NennoPizzaCore
//
//  Created by Vadym Bohdan on 11.07.2023.
//

import Foundation

final class DrinksMapper {
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> [RemoteDrink] {
        guard response.isOK, let remotePizzaMenu = try? JSONDecoder().decode([RemoteDrink].self, from: data) else {
            throw RemoteDrinksLoader.Error.invalidData
        }
        
        return remotePizzaMenu
    }
}
