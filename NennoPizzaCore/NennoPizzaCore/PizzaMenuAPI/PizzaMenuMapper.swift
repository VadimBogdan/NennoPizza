//
//  PizzaMenuMapper.swift
//  NennoPizzaCore
//
//  Created by Vadym Bohdan on 03.07.2023.
//

import Foundation

final class PizzaMenuMapper {
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> RemotePizzaMenu {
        guard response.isOK, let remotePizzaMenu = try? JSONDecoder().decode(RemotePizzaMenu.self, from: data) else {
            throw RemotePizzaMenuLoader.Error.invalidData
        }
        
        return remotePizzaMenu
    }
}
