//
//  PizzaCellController.swift
//  NennoPizzaCoreiOS
//
//  Created by Vadym Bohdan on 05.07.2023.
//

import UIKit
import NennoPizzaCore

public protocol PizzaCellControllerDelegate {
    func didRequestPizzaData()
    func didSelectPizza()
}

public final class PizzaCellController: PizzaView {
    private let delegate: PizzaCellControllerDelegate
    private var cell: PizzaMenuTableViewCell?
    
    public init(delegate: PizzaCellControllerDelegate) {
        self.delegate = delegate
    }
    
    func view(in tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell(for: indexPath)
        delegate.didRequestPizzaData()
        return cell!
    }
    
    func select() {
        delegate.didSelectPizza()
    }
    
    public func display(_ model: PizzaViewModel<UIImage>) {
        cell?.pizzaIngredientsLabel.text = model.ingredients
        cell?.pizzaNameLabel.text = model.name
        cell?.pizzaPriceLabel.text = model.price
        cell?.pizzaImageView.image = model.image

        cell?.onReuse = { [weak self] in
            self?.releaseCellForReuse()
        }
    }
    
    private func releaseCellForReuse() {
        cell = nil
    }
}
