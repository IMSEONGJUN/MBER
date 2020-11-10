//
//  RegisterationCoordinator.swift
//  MBER
//
//  Created by SEONGJUN on 2020/11/10.
//

import UIKit

class RegisterationCoordinator: BaseCoordinator {
    
    let navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("RegisterationCoordinator deinit")
    }
    
    override func start() {
        let viewModel = RegistrationViewModel()
        let vc = RegistrationController.create(with: viewModel)
        
        viewModel.goToLoginPageButtonTapped
            .bind(to: isCompleted)
            .disposed(by: disposeBag)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}
