//
//  Coordinator.swift
//  MBER
//
//  Created by SEONGJUN on 2020/11/08.
//

import UIKit

protocol Coordinator: AnyObject {
    
    var childCoordinator: [Coordinator] { get set }
    
    func start()
}

extension Coordinator {
    
    func add(coordinator: Coordinator) {
        childCoordinator.append(coordinator)
    }
    
    func remove(coordinator: Coordinator) {
        childCoordinator = childCoordinator.filter{ $0 !== coordinator }
    }
}
