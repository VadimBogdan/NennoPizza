//
//  DrinksViewController.swift
//  NennoPizzaCoreiOS
//
//  Created by Vadym Bohdan on 10.07.2023.
//

import UIKit
import NennoPizzaCore

public protocol DrinksViewControllerDelegate {
    func didRequestDrinks()
}

public final class DrinksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddedToCartView {

    private let addedToCartView = AttentionView(frame: .zero)
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    private var tableModel = [DrinkCellController]() {
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
    
    public func display(_ cellControllers: [DrinkCellController]) {
        tableModel = cellControllers
    }
    
    public func display(_ viewModel: AddedToCartViewModel) {
        addedToCartView.text = viewModel.message
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
    
    private func cellController(forRowAt indexPath: IndexPath) -> DrinkCellController {
        let controller = tableModel[indexPath.row]
        return controller
    }
    
    private func setup() {
        tableView.hideFirstTopCellSeparator()
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 82, right: 0)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        view.addSubview(addedToCartView)
        addedToCartView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addedToCartView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            addedToCartView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            addedToCartView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ])
    }
    
}
