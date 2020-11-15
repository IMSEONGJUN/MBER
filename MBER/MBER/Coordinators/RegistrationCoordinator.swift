//
//  RegisterationCoordinator.swift
//  MBER
//
//  Created by SEONGJUN on 2020/11/10.
//

import UIKit

final class RegistrationCoordinator: BaseCoordinator {
    
    let navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
        print("RegisterationCoordinator init")
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
        
        viewModel.isRegistered
            .filter{ $0 }
            .emit(onNext: { [weak self] _ in
                self?.switchToHomeVC()
            })
            .disposed(by: disposeBag)
            
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func switchToHomeVC() {
        var homeCoordinator: HomeCoordinator? = HomeCoordinator(navigationController: navigationController)
        self.add(coordinator: homeCoordinator)
        
        homeCoordinator?.isCompleted
            .subscribe(onNext: { [weak self] _ in
                self?.remove(coordinator: homeCoordinator)
                homeCoordinator = nil
            })
            .disposed(by: disposeBag)

        homeCoordinator?.start()
        
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
