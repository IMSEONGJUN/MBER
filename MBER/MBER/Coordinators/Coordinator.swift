//
//  Coordinator.swift
//  MBER
//
//  Created by SEONGJUN on 2020/11/08.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
