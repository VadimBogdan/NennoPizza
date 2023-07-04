//
//  PizzaMenuTableViewController.swift
//  NennoPizzaCoreiOS
//
//  Created by Vadym Bohdan on 03.07.2023.
//

import UIKit

public final class PizzaCellController {
    
    private var cell: PizzaMenuTableViewCell?
    
    func view(in tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell(for: indexPath)
        return cell!
    }
}

enum DesignConstants {
    static let pizzaMenuCellHeight: CGFloat = 178
}

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

final class PizzaMenuTableViewCell: UITableViewCell {
    
    private let pizzaBackgroundImageView = UIImageView()
    let pizzaImageView = UIImageView()
    let pizzaNameLabel = UILabel()
    let pizzaPriceLabel = UILabel()
    let pizzaIngredientsLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        contentView.addSubview(pizzaBackgroundImageView)
        contentView.addSubview(pizzaImageView)
        
        pizzaBackgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        pizzaImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pizzaImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pizzaImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            pizzaImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            pizzaImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            pizzaBackgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pizzaBackgroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            pizzaBackgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            pizzaBackgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        pizzaBackgroundImageView.image = .pizzaBackgroundImage
        
        let blurEffect = UIBlurEffect(style: .systemThinMaterialLight)
        let fxView = UIVisualEffectView(effect: blurEffect)
        fxView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(fxView)
        
        NSLayoutConstraint.activate([
            fxView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            fxView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            fxView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            fxView.heightAnchor.constraint(equalToConstant: 69)
        ])
        
        pizzaIngredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        pizzaNameLabel.translatesAutoresizingMaskIntoConstraints = false
        pizzaPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let priceView = UIView()
        priceView.translatesAutoresizingMaskIntoConstraints = false
        priceView.backgroundColor = .yellow
        
        let cartImageView = UIImageView(image: .cart)
        cartImageView.translatesAutoresizingMaskIntoConstraints = false
        cartImageView.tintColor = .white
        
        priceView.addSubview(pizzaPriceLabel)
        priceView.addSubview(cartImageView)
        
        NSLayoutConstraint.activate([
            cartImageView.heightAnchor.constraint(equalToConstant: 14),
            cartImageView.widthAnchor.constraint(equalToConstant: 14),
            cartImageView.leadingAnchor.constraint(equalTo: priceView.leadingAnchor, constant: 8),
            cartImageView.bottomAnchor.constraint(equalTo: priceView.bottomAnchor, constant: -7),
            pizzaPriceLabel.leadingAnchor.constraint(equalTo: cartImageView.trailingAnchor, constant: 4),
            pizzaPriceLabel.trailingAnchor.constraint(equalTo: priceView.trailingAnchor, constant: -4),
            pizzaPriceLabel.bottomAnchor.constraint(equalTo: priceView.bottomAnchor, constant: -4)
        ])
        
        fxView.contentView.addSubview(priceView)
        fxView.contentView.addSubview(pizzaIngredientsLabel)
        fxView.contentView.addSubview(pizzaNameLabel)
        
        NSLayoutConstraint.activate([
            priceView.heightAnchor.constraint(equalToConstant: 28),
            priceView.widthAnchor.constraint(equalToConstant: 64),
            priceView.trailingAnchor.constraint(equalTo: fxView.trailingAnchor, constant: -12),
            priceView.bottomAnchor.constraint(equalTo: fxView.bottomAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            pizzaIngredientsLabel.bottomAnchor.constraint(equalTo: fxView.bottomAnchor, constant: -12),
            pizzaIngredientsLabel.leadingAnchor.constraint(equalTo: fxView.leadingAnchor, constant: 12),
            pizzaIngredientsLabel.trailingAnchor.constraint(lessThanOrEqualTo: priceView.trailingAnchor, constant: -67)
        ])
        
        NSLayoutConstraint.activate([
            pizzaNameLabel.bottomAnchor.constraint(equalTo: pizzaIngredientsLabel.topAnchor),
            pizzaNameLabel.leadingAnchor.constraint(equalTo: pizzaIngredientsLabel.leadingAnchor),
            pizzaNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: fxView.trailingAnchor),
        ])
    }
}

extension UIImage {
    static let pizzaBackgroundImage = UIImage(named: "bg_wood",
                                              in: Bundle(for: PizzaMenuTableViewController.self),
                                              compatibleWith: nil)
    
    static let cart = UIImage(named: "ic_cart_button",
                              in: Bundle(for: PizzaMenuTableViewController.self),
                              compatibleWith: nil)
}

extension NSObject {
    public static var identifier: String {
        String(describing: self)
    }
}

extension UITableView {
    func register(_ cellClass: UITableViewCell.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.identifier)
    }
}

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! T
    }
}
