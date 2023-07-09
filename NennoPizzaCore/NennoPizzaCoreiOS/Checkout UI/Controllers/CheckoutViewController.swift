//
//  CheckoutViewController.swift
//  NennoPizzaCoreiOS
//
//  Created by Vadym Bohdan on 09.07.2023.
//

import UIKit

class CheckoutViewController: UIViewController {
    
    private let messageLabel = UILabel()
    private let footerView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        view.backgroundColor = .white
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        footerView.translatesAutoresizingMaskIntoConstraints = false
        footerView.backgroundColor = .redAttention
        messageLabel.font = .italicSystemFont(ofSize: 34)
        messageLabel.textColor = .redSecondary
        
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
