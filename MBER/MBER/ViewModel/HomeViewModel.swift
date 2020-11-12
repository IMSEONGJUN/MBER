//
//  HomeViewModel.swift
//  MBER
//
//  Created by SEONGJUN on 2020/11/07.
//

import Foundation
import RxSwift
import RxCocoa

struct HomeViewModel: HomeViewModelBindable {

    let user: Driver<User?>
    
    init(model: HomeModel = HomeModel()) {
        let userProxy = PublishRelay<User?>()
        user = userProxy.asDriver(onErrorJustReturn: nil)
    }
}
