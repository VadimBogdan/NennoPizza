//
//  PizzaMenuTableViewController.swift
//  NennoPizzaCoreiOS
//
//  Created by Vadym Bohdan on 03.07.2023.
//

import UIKit
import NennoPizzaCore

public protocol PizzaMenuViewControllerDelegate {
    func didRequestMenu()
}

public final class PizzaMenuTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddedToCartView {
    
    private let addedToCartView = AttentionView(frame: .zero)
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    private var pizzaCellControllers = [IndexPath: PizzaCellController]()
    
    private var tableModel = [PizzaCellController]() {
        didSet { tableView.reloadData() }
    }
    
    public var delegate: PizzaMenuViewControllerDelegate?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        setup()
        tableView.register(PizzaMenuTableViewCell.self)
        delegate?.didRequestMenu()
    }
    
    public func display(_ cellControllers: [PizzaCellController]) {
        tableModel = cellControllers
    }
    
    public func display(_ viewModel: AddedToCartViewModel) {
        addedToCartView.text = viewModel.message
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
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cellController(forRowAt: indexPath).view(in: tableView, for: indexPath)
    }
    
    private func cellController(forRowAt indexPath: IndexPath) -> PizzaCellController {
        let controller = tableModel[indexPath.row]
        pizzaCellControllers[indexPath] = controller
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
        view.addSubview(addedToCartView)
        addedToCartView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addedToCartView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            addedToCartView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            addedToCartView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ])
    }
    
}
