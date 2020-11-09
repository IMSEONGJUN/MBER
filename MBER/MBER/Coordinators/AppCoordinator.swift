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
        let authCoordinator = AuthCoordinator(navigationController: navigationController)
        
        self.add(coordinator: authCoordinator)
        
        authCoordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        authCoordinator.isCompleted
            .subscribe(onNext: { [weak self] _ in
                self?.remove(coordinator: authCoordinator)
            })
            .disposed(by: disposeBag)
        
    }
}
