//
//  DrinkCellController.swift
//  NennoPizzaCoreiOS
//
//  Created by Vadym Bohdan on 10.07.2023.
//

import NennoPizzaCore
import SwiftUI

public protocol DrinkCellControllerDelegate {
    func didRequestDrinkItem()
    func didSelectDrink()
}

public final class DrinkCellController: DrinkView {
    
    private let delegate: DrinkCellControllerDelegate
    private var cell: UITableViewCell?
    
    public init(delegate: DrinkCellControllerDelegate) {
        self.delegate = delegate
    }
    
    func view(in tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell(for: indexPath)
        delegate.didRequestDrinkItem()
        return cell!
    }
    
    func select() {
        delegate.didSelectDrink()
    }
    
    public func display(_ model: DrinkViewModel) {
        cell?.selectionStyle = .none
        cell?.contentConfiguration = UIHostingConfiguration {
            HStack {
                Text(model.name)
                Spacer()
                Text(model.price)
            }
            .padding(.horizontal, 12)
            .font(.system(size: 17, weight: .regular))
        }
    }
    
}
