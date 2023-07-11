//
//  CartViewAdapter.swift
//  NennoPizza
//
//  Created by Vadym Bohdan on 08.07.2023.
//

import NennoPizzaCoreiOS
import NennoPizzaCore
import Foundation

final class CartViewAdapter: CartView, CartTotalPriceView {
    
    private weak var controller: CartViewController?
    
    init(controller: CartViewController?) {
        self.controller = controller
    }
    
    func display(_ viewModel: CartViewModel) {
        controller?.display(viewModel.items.map({ model in
            let adapter = CartItemDataLoaderPresentationAdapter(model: model)
            let view = CartItemCellController(delegate: adapter)
            
            let presenter = CartItemPresenter(cartItemView: WeakRefVirtualProxy(view),
                                              priceFormatter: {
                NumberFormatter.format($0, currency: Constants.usdCurrencySymbol)
            })
            
            adapter.presenter = presenter
            
            return view
        }))
    }
    
    func display(_ viewModel: CartTotalPriceViewModel) {
        let cartFooterController = CartFooterController()
        controller?.display(cartFooterController)
        cartFooterController.display(viewModel)
    }
    
}
