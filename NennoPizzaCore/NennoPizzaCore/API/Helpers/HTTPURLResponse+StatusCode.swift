//
//  HTTPURLResponse+StatusCode.swift
//  NennoPizzaCore
//
//  Created by Vadym Bohdan on 03.07.2023.
//

import Foundation

extension HTTPURLResponse {
    private static var OK_200: Int { return 200 }
    
    var isOK: Bool {
        return statusCode == HTTPURLResponse.OK_200
    }
}
