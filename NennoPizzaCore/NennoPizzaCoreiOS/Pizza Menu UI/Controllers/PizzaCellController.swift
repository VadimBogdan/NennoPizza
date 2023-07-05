//
//  PizzaCellController.swift
//  NennoPizzaCoreiOS
//
//  Created by Vadym Bohdan on 05.07.2023.
//

import UIKit
import NennoPizzaCore

public final class PizzaCellController: PizzaView {
    
    private var cell: PizzaMenuTableViewCell?
    
    func view(in tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell(for: indexPath)
        return cell!
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
