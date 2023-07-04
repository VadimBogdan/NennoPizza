//
//  PizzaMenuTableViewController.swift
//  NennoPizzaCoreiOS
//
//  Created by Vadym Bohdan on 03.07.2023.
//

import UIKit

public final class PizzaMenuTableViewController: UITableViewController {
    
}

final class PizzaMenuTableViewCell: UITableViewCell {
    
    let pizzaImageView = UIImageView()
    let pizzaNameLabel = UILabel()
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
        contentView.addSubview(pizzaImageView)
        
        pizzaImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pizzaImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pizzaImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            pizzaImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            pizzaImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        let blurEffect = UIBlurEffect(style: .systemThinMaterialLight)
        let fxView = UIVisualEffectView(effect: blurEffect)
        fxView.translatesAutoresizingMaskIntoConstraints = false
        let fxViewHeight: CGFloat = 69
        
        contentView.addSubview(fxView)
        
        NSLayoutConstraint.activate([
            fxView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            fxView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            fxView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            fxView.heightAnchor.constraint(equalToConstant: fxViewHeight)
        ])
        
        pizzaIngredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        pizzaNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let priceView = UIView()
        priceView.translatesAutoresizingMaskIntoConstraints = false
        priceView.backgroundColor = .yellow
        
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
