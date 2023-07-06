//
//  AttentionView.swift
//  NennoPizzaCoreiOS
//
//  Created by Vadym Bohdan on 06.07.2023.
//

import UIKit

class AttentionView: UIView {
    
    private let label = UILabel()
    
    public var text: String? {
        get { isVisible ? label.text : nil }
        set { setMessageAnimated(newValue) }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    private func setup() {
        label.text = nil
        alpha = 0
        backgroundColor = .redAttention
        
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 3)
        ])
    }
    
    private var isVisible: Bool {
        alpha > 0
    }
    
    private func setMessageAnimated(_ message: String?) {
        if let message = message {
            showAnimated(message)
        } else {
            hideMessageAnimated()
        }
    }
    
    private func showAnimated(_ message: String) {
        label.text = message
        
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1
        }
    }
    
    @IBAction private func hideMessageAnimated() {
        UIView.animate(
            withDuration: 0.25,
            animations: { self.alpha = 0 },
            completion: { completed in
                if completed { self.label.text = nil }
            })
    }
    
}

