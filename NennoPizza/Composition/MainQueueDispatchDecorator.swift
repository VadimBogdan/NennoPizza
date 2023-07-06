//
//  MainQueueDispatchDecorator.swift
//  NennoPizza
//
//  Created by Vadym Bohdan on 06.07.2023.
//

import Foundation
import NennoPizzaCore

final class MainQueueDispatchDecorator<T> {
    private let decoratee: T
    
    init(decoratee: T) {
        self.decoratee = decoratee
    }
    
    func dispatch(completion: @escaping () -> Void) {
        guard Thread.isMainThread else {
            return DispatchQueue.main.async(execute: completion)
        }
        
        completion()
    }
}

extension MainQueueDispatchDecorator: PizzaMenuAndIngredientsLoader where T == PizzaMenuAndIngredientsLoader {
    func load(completion: @escaping (PizzaMenuAndIngredientsLoader.Result) -> Void) {
        decoratee.load { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}

extension MainQueueDispatchDecorator: PizzaImageDataLoader where T == PizzaImageDataLoader {
    func loadImageData(from url: URL, completion: @escaping (PizzaImageDataLoader.Result) -> Void) {
        decoratee.loadImageData(from: url) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}
