//
//  CartViewController.swift
//  NennoPizzaCoreiOS
//
//  Created by Vadym Bohdan on 06.07.2023.
//

import UIKit
import NennoPizzaCore

public protocol CartViewControllerDelegate {
    func didSelectCheckout()
    func didRequestCart()
    func didSelectDrinks()
}

public final class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    public let checkoutButton = UIButton()
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    private var tableModel = [CartItemCellController]() {
        didSet { tableView.reloadData() }
    }
    private var footerModel: CartFooterController?
    
    public var delegate: CartViewControllerDelegate?

    public override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self)
        setup()
        
        delegate?.didRequestCart()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        delegate?.didRequestCart()
    }
    
    @objc private func didSelectDrinks() {
        delegate?.didSelectDrinks()
    }
    
    @objc private func checkout() {
        delegate?.didSelectCheckout()
    }
    
    public func display(_ cellControllers: [CartItemCellController]) {
        tableModel = cellControllers
    }
    
    public func display(_ footerController: CartFooterController) {
        footerModel = footerController
        tableView.tableFooterView = footerModel?.view()
    }
        
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cellController(forRowAt: indexPath).view(in: tableView, for: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        DesignConstants.cartItemCellHeight
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableModel.count
    }
    
    private func cellController(forRowAt indexPath: IndexPath) -> CartItemCellController {
        let controller = tableModel[indexPath.row]
        return controller
    }
    
    private func setup() {
        navigationItem.backButtonDisplayMode = .minimal
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .drinksNavbar?.withRenderingMode(.alwaysOriginal),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didSelectDrinks))
        tableView.hideFirstTopCellSeparator()
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 82, right: 0)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        checkoutButton.translatesAutoresizingMaskIntoConstraints = false
        checkoutButton.addTarget(self, action: #selector(checkout), for: .touchUpInside)
        checkoutButton.backgroundColor = .redAttention
        checkoutButton.setTitleColor(.white, for: .normal)
        checkoutButton.setTitleColor(.white.withAlphaComponent(0.5), for: .highlighted)
        checkoutButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        view.addSubview(tableView)
        view.addSubview(checkoutButton)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            checkoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            checkoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            checkoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            checkoutButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
