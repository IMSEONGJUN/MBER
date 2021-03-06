//
//  AuthCoordinator.swift
//  MBER
//
//  Created by SEONGJUN on 2020/11/09.
//

import UIKit
import RxSwift
import RxCocoa

class LoginCoordinator: BaseCoordinator {
    let navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    override func start() {
//        if loginCheck() {
//            let viewModel = HomeViewModel()
//            let vc = HomeController.create(with: viewModel)
//            viewModel.goToRegisterButtonTapped
//                .subscribe(onNext: { [weak self] in
//                    guard let self = self else { return }
//                    self.pushRegistrationVC(in: self.navigationController)
//                })
//                .disposed(by: disposeBag)
            
//            navigationController.pushViewController(vc, animated: true)
//        } else {
            let viewModel = LoginViewModel()
            let vc = LoginController.create(with: viewModel)
            
            viewModel.goToRegisterButtonTapped
                .subscribe(onNext: { [weak self] in
                    guard let self = self else { return }
                    self.pushRegistrationVC(in: self.navigationController)
                })
                .disposed(by: disposeBag)
            
            viewModel.isLoginCompleted
                .emit(onNext: { _ in
                    self.remove(coordinator: self)
                    let homeCoordinator = HomeCoordinator(navigationController: self.navigationController)
                    self.add(coordinator: homeCoordinator)
                    homeCoordinator.start()
                })
                .disposed(by: disposeBag)
        
            navigationController?.pushViewController(vc, animated: true)
//        }
    }
    

    func pushRegistrationVC(in navigationController: UINavigationController?){
        let registerationCoordinator = RegisterationCoordinator(navigationController: navigationController)
        self.add(coordinator: registerationCoordinator)
        
        registerationCoordinator.isCompleted
            .subscribe(onNext: {[weak self] _ in
                registerationCoordinator.navigationController?.popViewController(animated: true)
                self?.remove(coordinator: registerationCoordinator)
            })
            .disposed(by: disposeBag)
        
        registerationCoordinator.start()
    }
}
