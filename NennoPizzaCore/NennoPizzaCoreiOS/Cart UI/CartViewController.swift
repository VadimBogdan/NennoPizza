//
//  CartViewController.swift
//  NennoPizzaCoreiOS
//
//  Created by Vadym Bohdan on 06.07.2023.
//

import UIKit
import SwiftUI

public struct CartItemViewModel {
    public let name: String
    public let price: String
}

public protocol CartItemView {
    func display(_ model: CartItemViewModel)
}

public protocol CartItemCellControllerDelegate {
    func didSelectCartItem()
}

class CartItemCellController: CartItemView {
    
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

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    private var tableModel = [CartItemCellController]() {
        didSet { tableView.reloadData() }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        setup()
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cellController(forRowAt: indexPath).view(in: tableView, for: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellController(forRowAt: indexPath).select()
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        DesignConstants.pizzaMenuCellHeight
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableModel.count
    }
    
    private func cellController(forRowAt indexPath: IndexPath) -> CartItemCellController {
        let controller = tableModel[indexPath.row]
        return controller
    }
    
    private func setup() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
