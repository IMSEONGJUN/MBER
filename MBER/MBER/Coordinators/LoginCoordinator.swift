//
//  AuthCoordinator.swift
//  MBER
//
//  Created by SEONGJUN on 2020/11/09.
//

import UIKit
import RxSwift
import RxCocoa

final class LoginCoordinator: BaseCoordinator {
    let navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("LoginCoordinator deinit")
    }
    
    override func start() {
        if loginCheck() {
            loggedInStatus()
        } else {
            loggedOutStatus()
        }
    }
    
    func loggedInStatus() {
        var homeCoordinator: HomeCoordinator? = HomeCoordinator(navigationController: self.navigationController)
        self.add(coordinator: homeCoordinator)
        
        homeCoordinator?.isCompleted
            .subscribe(onNext: {[weak self] _ in
                self?.remove(coordinator: homeCoordinator)
                homeCoordinator?.navigationController?.popViewController(animated: true)
                homeCoordinator = nil
            })
            .disposed(by: disposeBag)
        
        homeCoordinator?.start()
    }
    
    func loggedOutStatus() {
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
                guard let self = self else { return }
                self.isCompleted.accept(Void())
                let homeCoordinator = HomeCoordinator(navigationController: self.navigationController)
                self.add(coordinator: homeCoordinator)
                homeCoordinator.start()
                
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                    let window = UIWindow(windowScene: windowScene)
                    window.backgroundColor = .systemBackground
                    window.rootViewController = self.navigationController
                    
                    let sceneDelegate = windowScene.delegate as? SceneDelegate
                    window.makeKeyAndVisible()
                    sceneDelegate?.window = window
                }
            })
            .disposed(by: disposeBag)
    
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushRegistrationVC(in navigationController: UINavigationController?){
        var registrationCoordinator: RegistrationCoordinator? = RegistrationCoordinator(navigationController: navigationController)
        self.add(coordinator: registrationCoordinator)
        
        registrationCoordinator?.isCompleted
            .subscribe(onNext: {[weak self] _ in
                registrationCoordinator?.navigationController?.popViewController(animated: true)
                self?.remove(coordinator: registrationCoordinator)
                registrationCoordinator = nil
            })
            .disposed(by: disposeBag)
        
        registrationCoordinator?.start()
    }
}
