//
//  BaseCoordinator.swift
//  MBER
//
//  Created by SEONGJUN on 2020/11/09.
//

import UIKit
import RxSwift
import RxCocoa

class BaseCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator?] = []
    
    let isCompleted = PublishRelay<Void>()
    
    var disposeBag = DisposeBag()
    
    func start() {
        fatalError("Children should implement `start`.")
    }
}
