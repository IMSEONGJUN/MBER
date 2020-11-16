//
//  HomeCoordinator.swift
//  MBER
//
//  Created by SEONGJUN on 2020/11/09.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeCoordinator: BaseCoordinator {
    let navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let viewModel = HomeViewModel()
        let vc = HomeController.create(with: viewModel)
        
        viewModel.logoutButtonTapped
            .subscribe(onNext: {
                AuthManager.shared.doLogout()
                    .subscribe { [weak self] completable in
                        switch completable {
                        case .completed:
                            print("Successfully logged out")
                            self?.isCompleted.accept(Void())
                            self?.switchToLoginVC()
                        case .error(let err):
                            print("Failed to logout", err)
                        }
                    }
                    .disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func switchToLoginVC() {
        var loginCoordinator: LoginCoordinator? = LoginCoordinator(navigationController: navigationController)
        self.add(coordinator: loginCoordinator)
        
        loginCoordinator?.isCompleted
            .subscribe(onNext: { [weak self] _ in
                self?.remove(coordinator: loginCoordinator)
                loginCoordinator = nil
            })
            .disposed(by: disposeBag)

        loginCoordinator?.start()
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.backgroundColor = .systemBackground
            window.rootViewController = navigationController
            
            let sceneDelegate = windowScene.delegate as? SceneDelegate
            window.makeKeyAndVisible()
            sceneDelegate?.window = window
        }
    }
}
