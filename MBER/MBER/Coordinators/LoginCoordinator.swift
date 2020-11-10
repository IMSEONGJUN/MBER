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
    
    deinit {
        print("LoginCoordinator deinit")
    }
    
    override func start() {
        if loginCheck() && false {
            let homeCoordinator = HomeCoordinator(navigationController: self.navigationController)
            self.add(coordinator: homeCoordinator)
            
            homeCoordinator.isCompleted
                .subscribe(onNext: {[weak self] _ in
                    self?.remove(coordinator: homeCoordinator)
                    homeCoordinator.navigationController?.popViewController(animated: true)
                })
                .disposed(by: disposeBag)
            
            homeCoordinator.start()
        } else {
            let viewModel = LoginViewModel()
            let vc = LoginController.create(with: viewModel)
            
            viewModel.goToRegisterButtonTapped
                .subscribe(onNext: { [weak self] in
                    guard let self = self else { return }
                    self.pushRegistrationVC(in: self.navigationController)
                })
                .disposed(by: disposeBag)
        
            viewModel.isLoginCompleted
                .map{ _ in Void() }
                .emit(to: self.isCompleted)
                .disposed(by: disposeBag)
        
            viewModel.isLoginCompleted
                .emit(onNext: { [weak self] _ in
                    let homeCoordinator = HomeCoordinator(navigationController: self?.navigationController)
                    self?.add(coordinator: homeCoordinator)
                    homeCoordinator.start()
                })
                .disposed(by: disposeBag)
        
            navigationController?.pushViewController(vc, animated: true)
        }
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
