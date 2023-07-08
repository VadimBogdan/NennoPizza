//
//  CartFooterController.swift
//  NennoPizzaCoreiOS
//
//  Created by Vadym Bohdan on 07.07.2023.
//

import NennoPizzaCore
import SwiftUI

public final class CartFooterController: CartTotalPriceView {
    
    private var footer: UITableViewHeaderFooterView?
    
    public init() {}
    
    func view() -> UITableViewHeaderFooterView {
        footer = UITableViewHeaderFooterView()
        return footer!
    }
    
    public func display(_ model: CartTotalPriceViewModel) {        
        footer?.contentConfiguration = UIHostingConfiguration {
            HStack {
                Text(model.title)
                Spacer()
                Text(model.price)
            }
            .foregroundColor(Color(UIColor.primaryDark))
            .font(.system(size: 17, weight: .bold))
            .padding(.horizontal, 12)
            .padding(.top, 64)
        }
        .minSize(height: 44)
    }
    
}
