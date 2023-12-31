//
//  RemoteCheckoutUploader.swift
//  NennoPizzaCore
//
//  Created by Vadym Bohdan on 09.07.2023.
//

import Foundation

public final class RemoteCheckoutUploader: CheckoutUploader {
    
    public typealias Result = CheckoutUploader.Result
    
    public enum Error: Swift.Error {
        case connectivity
    }
    
    private let url: URL
    private let client: HTTPClient
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func upload(pizzas: [Pizza], drinkIds: [Int], completion: @escaping (Result) -> Void) {
        let checkoutJSONData = try! JSONEncoder().encode(RemoteCheckout(pizzas: pizzas.toRemote(), drinks: drinkIds))
        client.post(to: url, with: checkoutJSONData) { [weak self] result in
            guard self != nil else { return }
            
            switch result {
            case let .success((_, response)):
                guard response.isOK else {
                    completion(.failure(Error.connectivity))
                    return
                }
                completion(.success(()))
                
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
    
}

private struct RemoteCheckout: Encodable {
    let pizzas: [RemotePizza]
    let drinks: [Int]
}

private extension Array where Element == Pizza {
    func toRemote() -> [RemotePizza] {
        map { RemotePizza(ingredients: $0.ingredients, name: $0.name, imageUrl: $0.url) }
    }
}
