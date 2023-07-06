//
//  WeakRefVirtualProxy.swift
//  NennoPizza
//
//  Created by Vadym Bohdan on 06.07.2023.
//

import UIKit
import NennoPizzaCore

final class WeakRefVirtualProxy<T: AnyObject> {
    private weak var object: T?
    
    init(_ object: T) {
        self.object = object
    }
}

extension WeakRefVirtualProxy: PizzaView where T: PizzaView, T.Image == UIImage {
    func display(_ viewModel: PizzaViewModel<UIImage>) {
        object?.display(viewModel)
    }
}

extension WeakRefVirtualProxy: AddedToCartView where T: AddedToCartView {
    func display(_ viewModel: AddedToCartViewModel) {
        object?.display(viewModel)
    }
}
