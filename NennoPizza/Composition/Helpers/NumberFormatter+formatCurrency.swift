//
//  NumberFormatter+formatCurrency.swift
//  NennoPizza
//
//  Created by Vadym Bohdan on 08.07.2023.
//

import Foundation

extension NumberFormatter {
    private static let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    static func format(_ value: Double, currency: String) -> String {
        return currency + (currencyFormatter.string(for: value) ?? "---")
    }
}
