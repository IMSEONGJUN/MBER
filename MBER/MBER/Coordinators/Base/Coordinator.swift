//
//  Coordinator.swift
//  MBER
//
//  Created by SEONGJUN on 2020/11/08.
//

import UIKit

protocol Coordinator: AnyObject {
    
    var childCoordinators: [Coordinator] { get set }
    
    func start()
}

extension Coordinator {
    
    func add(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func remove(coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter{ $0 !== coordinator }
    }
}
