//
//  DesignConstants.swift
//  NennoPizzaCoreiOS
//
//  Created by Vadym Bohdan on 05.07.2023.
//

import UIKit

enum DesignConstants {
    static let pizzaMenuCellHeight: CGFloat = 178
    static let cartItemCellHeight: CGFloat = 44
    static let drinkItemCellHeight: CGFloat = 44
}

extension UIImage {
    static let pizzaBackgroundImage = UIImage(named: "bg_wood",
                                              in: Bundle(for: PizzaMenuViewController.self),
                                              compatibleWith: nil)
    
    static let cart = UIImage(named: "ic_cart_button",
                              in: Bundle(for: PizzaMenuViewController.self),
                              compatibleWith: nil)
    
    static let cartNavbar = UIImage(named: "ic_cart_navbar",
                              in: Bundle(for: PizzaMenuViewController.self),
                              compatibleWith: nil)
    
}

extension UIColor {
    static let primaryDark = UIColor("#4A4A4A")
    static let secondaryOrange = UIColor("#FFCD2B")
    static let redSecondary = UIColor("#DF4E4A")
    public static let redAttention = UIColor("#E14D45")
}
