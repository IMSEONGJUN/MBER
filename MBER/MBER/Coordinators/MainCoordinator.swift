//
//  MainCoordinator.swift
//  MBER
//
//  Created by SEONGJUN on 2020/11/08.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        if loginCheck() {
            let vc = LoginController.create(with: LoginViewModel())
//            let vc = HomeController.create(with: HomeViewModel())
            vc.coordinator = self
            navigationController.pushViewController(vc, animated: true)
        } else {
            let vc = LoginController.create(with: LoginViewModel())
            vc.coordinator = self
            navigationController.pushViewController(vc, animated: true)
        }
    }
    
    func goRegistrationVC() {
        let vc = RegistrationController.create(with: RegistrationViewModel())
        vc.coordinatior = self
        navigationController.pushViewController(vc, animated: true)
    }
    
}
