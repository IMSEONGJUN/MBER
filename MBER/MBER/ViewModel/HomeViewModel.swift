//
//  HomeViewModel.swift
//  MBER
//
//  Created by SEONGJUN on 2020/11/07.
//

import Foundation
import RxSwift
import RxCocoa
import CoreLocation
import RxCoreLocation

struct HomeViewModel: HomeViewModelBindable {

    // Input
    let logoutButtonTapped = PublishRelay<Void>()
    
    // Output
    let user: Driver<User?>
    
    private let manager = CLLocationManager()
    
    init(model: HomeModel = HomeModel()) {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        let userProxy = PublishRelay<User?>()
        user = userProxy.asDriver(onErrorJustReturn: nil)
    }
}
