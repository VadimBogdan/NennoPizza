//
//  SimplePizzaImageCachedLoader.swift
//  NennoPizzaCore
//
//  Created by Vadym Bohdan on 05.07.2023.
//

import Foundation

public final class SimplePizzaImageDataCachedLoader: PizzaImageDataLoader {
    private let cache = NSCache<NSURL, NSData>()
    private let loader: PizzaImageDataLoader
    
    public init(loader: PizzaImageDataLoader) {
        self.loader = loader
    }
    
    public func loadImageData(from url: URL, completion: @escaping (PizzaImageDataLoader.Result) -> Void) {
        if let data = cache.object(forKey: url as NSURL) {
            completion(.success(data as Data))
            return
        }
        loader.loadImageData(from: url) { [weak self] result in
            if case let .success(data) = result {
                self?.cache.setObject(data as NSData, forKey: url as NSURL)
            }
            completion(result)
        }
    }
}
