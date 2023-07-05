//
//  PizzaMenuTableViewCell.swift
//  NennoPizzaCoreiOS
//
//  Created by Vadym Bohdan on 05.07.2023.
//

import UIKit

final class PizzaMenuTableViewCell: UITableViewCell {
    
    private let pizzaBackgroundImageView = UIImageView()
    let pizzaImageView = UIImageView()
    let pizzaNameLabel = UILabel()
    let pizzaPriceLabel = UILabel()
    let pizzaIngredientsLabel = UILabel()
    
    var onReuse: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        onReuse?()
    }
    
    private func setupUI() {
        setupFormatting()
        
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
        
        let blurEffect = UIBlurEffect(style: .systemMaterialLight)
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
        priceView.layer.cornerRadius = 4
        priceView.translatesAutoresizingMaskIntoConstraints = false
        priceView.backgroundColor = .secondaryOrange
        
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
    
    private func setupFormatting() {
        pizzaPriceLabel.font = .systemFont(ofSize: 16, weight: .bold)
        pizzaPriceLabel.textColor = .white
        pizzaNameLabel.font = .systemFont(ofSize: 24, weight: .bold)
        pizzaNameLabel.textColor = .primaryDark
        pizzaIngredientsLabel.font = .systemFont(ofSize: 14, weight: .regular)
        pizzaIngredientsLabel.textColor = .primaryDark
    }
}
