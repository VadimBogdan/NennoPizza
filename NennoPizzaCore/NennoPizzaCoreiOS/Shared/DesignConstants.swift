//
//  DesignConstants.swift
//  NennoPizzaCoreiOS
//
//  Created by Vadym Bohdan on 05.07.2023.
//

import UIKit

enum DesignConstants {
    static let pizzaMenuCellHeight: CGFloat = 178
}

extension UIImage {
    static let pizzaBackgroundImage = UIImage(named: "bg_wood",
                                              in: Bundle(for: PizzaMenuTableViewController.self),
                                              compatibleWith: nil)
    
    static let cart = UIImage(named: "ic_cart_button",
                              in: Bundle(for: PizzaMenuTableViewController.self),
                              compatibleWith: nil)
}

extension UIColor {
    static let primaryDark = UIColor("#4A4A4A")
    static let secondaryOrange = UIColor("#FFCD2B")
    static let redAttention = UIColor("#E14D45")
}
