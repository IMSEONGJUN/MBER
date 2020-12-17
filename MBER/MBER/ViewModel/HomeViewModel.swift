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
    let manager = CLLocationManager()
    
    init(model: HomeModel = HomeModel()) {
        let userProxy = PublishRelay<User?>()
        user = userProxy.asDriver(onErrorJustReturn: nil)
        
        enableLocationServices()
    }
    
    func enableLocationServices() {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
            print("notDetermined")
        case .restricted, .denied:
            break
        case .authorizedAlways:
            print("authorizedAlways")
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
        default:
            break
        }
    }
}
