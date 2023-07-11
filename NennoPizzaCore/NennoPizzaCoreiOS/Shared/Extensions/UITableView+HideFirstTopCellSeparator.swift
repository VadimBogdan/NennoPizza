//
//  UITableView+HideFirstTopCellSeparator.swift
//  NennoPizzaCoreiOS
//
//  Created by Vadym Bohdan on 11.07.2023.
//

import UIKit

extension UITableView {
    func hideFirstTopCellSeparator() {
        tableHeaderView = UIView()
    }
}
