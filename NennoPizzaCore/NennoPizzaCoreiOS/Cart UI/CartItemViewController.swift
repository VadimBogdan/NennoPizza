//
//  CartItemViewController.swift
//  NennoPizzaCoreiOS
//
//  Created by Vadym Bohdan on 06.07.2023.
//

import NennoPizzaCore
import SwiftUI

public protocol CartItemCellControllerDelegate {
    func didSelectCartItem()
}

public final class CartItemCellController: CartItemView {
    
    private let delegate: CartItemCellControllerDelegate
    private var cell: UITableViewCell?
    
    public init(delegate: CartItemCellControllerDelegate) {
        self.delegate = delegate
    }
    
    func view(in tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell(for: indexPath)
        return cell!
    }
    
    func select() {
        delegate.didSelectCartItem()
    }
    
    public func display(_ model: CartItemViewModel) {
        cell?.contentConfiguration = UIHostingConfiguration {
            HStack {
                Text(model.name)
                Spacer()
                Text(model.price)
            }
            .padding(.horizontal, 12)
        }
    }
    
}
