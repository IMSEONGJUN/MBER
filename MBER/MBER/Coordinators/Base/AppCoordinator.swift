//
//  AppCoordinator.swift
//  MBER
//
//  Created by SEONGJUN on 2020/11/09.
//

import UIKit
import RxSwift
import RxCocoa

class AppCoordinator: BaseCoordinator {
    
    let window: UIWindow
    
    init(window: UIWindow){
        self.window = window
        super.init()
    }
    
    override func start() {
        let navigationController = UINavigationController()
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        
        self.add(coordinator: loginCoordinator)
        
        loginCoordinator.isCompleted
            .subscribe(onNext: { [weak self] _ in
                self?.remove(coordinator: loginCoordinator)
            })
            .disposed(by: disposeBag)
        
        loginCoordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
