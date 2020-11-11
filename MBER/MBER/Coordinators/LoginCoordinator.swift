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
        if !loginCheck() {
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
                .emit(onNext: { [weak self] _ in
                    self?.isCompleted.accept(Void())
                    let homeCoordinator = HomeCoordinator(navigationController: self?.navigationController)
                    self?.add(coordinator: homeCoordinator)
                    homeCoordinator.start()
                })
                .disposed(by: disposeBag)
        
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func pushRegistrationVC(in navigationController: UINavigationController?){
        let registrationCoordinator = RegistrationCoordinator(navigationController: navigationController)
        self.add(coordinator: registrationCoordinator)
        
        registrationCoordinator.isCompleted
            .subscribe(onNext: {[weak self] _ in
                registrationCoordinator.navigationController?.popViewController(animated: true)
                self?.remove(coordinator: registrationCoordinator)
            })
            .disposed(by: disposeBag)
        
        registrationCoordinator.start()
    }
}
