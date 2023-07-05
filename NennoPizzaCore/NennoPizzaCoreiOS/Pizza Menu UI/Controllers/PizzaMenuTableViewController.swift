//
//  PizzaMenuTableViewController.swift
//  NennoPizzaCoreiOS
//
//  Created by Vadym Bohdan on 03.07.2023.
//

import UIKit
import NennoPizzaCore

public final class PizzaMenuTableViewController: UITableViewController {
    
    private var pizzaCellControllers = [IndexPath: PizzaCellController]()
    
    private var tableModel = [PizzaCellController]() {
        didSet { tableView.reloadData() }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(PizzaMenuTableViewCell.self)
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        DesignConstants.pizzaMenuCellHeight
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableModel.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cellController(forRowAt: indexPath).view(in: tableView, for: indexPath)
    }
         
    private func cellController(forRowAt indexPath: IndexPath) -> PizzaCellController {
        let controller = tableModel[indexPath.row]
        pizzaCellControllers[indexPath] = controller
        return controller
    }
}
