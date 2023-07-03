//
//  IngredientsMapper.swift
//  NennoPizzaCore
//
//  Created by Vadym Bohdan on 03.07.2023.
//

import Foundation

final class IngredientsMapper {
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> [RemoteIngredient] {
        guard response.isOK, let remotePizzaMenu = try? JSONDecoder().decode([RemoteIngredient].self, from: data) else {
            throw RemoteIngredientsLoader.Error.invalidData
        }
        
        return remotePizzaMenu
    }
}
