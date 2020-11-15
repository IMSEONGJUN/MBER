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
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
