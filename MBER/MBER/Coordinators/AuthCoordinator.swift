//
//  AuthCoordinator.swift
//  MBER
//
//  Created by SEONGJUN on 2020/11/09.
//

import UIKit
import RxSwift
import RxCocoa

class AuthCoordinator: BaseCoordinator {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
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
                    let navi = UINavigationController()
                    let homeCoordinator = HomeCoordinator(navigationController: navi)
                    self.add(coordinator: homeCoordinator)
                    homeCoordinator.start()
                })
                .disposed(by: disposeBag)
        
            navigationController.pushViewController(vc, animated: true)
//        }
    }
    

    func pushRegistrationVC(in navigationController: UINavigationController?){
        let viewModel = RegistrationViewModel()
        let vc = RegistrationController.create(with: viewModel)
        viewModel.goToLoginPageButtonTapped
            .subscribe(onNext: { [weak self] in
                self?.navigationController.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        navigationController?.pushViewController(vc, animated: true)
    }
}
