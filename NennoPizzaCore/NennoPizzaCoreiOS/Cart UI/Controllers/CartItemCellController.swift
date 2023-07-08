//
//  CartItemCellController.swift
//  NennoPizzaCoreiOS
//
//  Created by Vadym Bohdan on 06.07.2023.
//

import NennoPizzaCore
import SwiftUI

public protocol CartItemCellControllerDelegate {
    func didRequestCartItem()
}

public final class CartItemCellController: CartItemView {
    
    private let delegate: CartItemCellControllerDelegate
    private var cell: UITableViewCell?
    
    public init(delegate: CartItemCellControllerDelegate) {
        self.delegate = delegate
    }
    
    func view(in tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell(for: indexPath)
        delegate.didRequestCartItem()
        return cell!
    }
    
    public func display(_ model: CartItemViewModel) {
        cell?.selectionStyle = .none
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
