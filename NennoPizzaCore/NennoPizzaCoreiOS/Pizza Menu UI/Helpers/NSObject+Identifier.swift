//
//  NSObject+Identifier.swift
//  NennoPizzaCoreiOS
//
//  Created by Vadym Bohdan on 05.07.2023.
//

import Foundation

extension NSObject {
    public static var identifier: String {
        String(describing: self)
    }
}
