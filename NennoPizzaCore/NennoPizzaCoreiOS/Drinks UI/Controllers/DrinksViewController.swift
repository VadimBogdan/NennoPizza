//
//  DrinksViewController.swift
//  NennoPizzaCoreiOS
//
//  Created by Vadym Bohdan on 10.07.2023.
//

import UIKit

import SwiftUI

public protocol DrinkItemCellControllerDelegate {
    func didRequestDrinkItem()
    func didSelectDrink()
}

public struct DrinkItemViewModel {
    let name: String
    let price: String
}

public protocol DrinkItemView {
    func display(_ model: DrinkItemViewModel)
}

public final class DrinkItemCellController: DrinkItemView {
    
    private let delegate: DrinkItemCellControllerDelegate
    private var cell: UITableViewCell?
    
    public init(delegate: DrinkItemCellControllerDelegate) {
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
    
    public func display(_ model: DrinkItemViewModel) {
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

public protocol DrinksViewControllerDelegate {
    func didRequestDrinks()
}

final class DrinksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    private var tableModel = [DrinkItemCellController]() {
        didSet { tableView.reloadData() }
    }
    
    public var delegate: DrinksViewControllerDelegate?

    public override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self)
        
        setup()
        
        delegate?.didRequestDrinks()
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cellController(forRowAt: indexPath).view(in: tableView, for: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellController(forRowAt: indexPath).select()
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        DesignConstants.drinkItemCellHeight
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableModel.count
    }
    
    private func cellController(forRowAt indexPath: IndexPath) -> DrinkItemCellController {
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
