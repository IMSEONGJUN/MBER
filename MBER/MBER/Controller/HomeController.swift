//
//  HomeController.swift
//  MBER
//
//  Created by SEONGJUN on 2020/11/07.
//

import UIKit
import Firebase
import RxSwift
import RxCocoa
import CoreLocation
import MapKit
import SnapKit

protocol HomeViewModelBindable: ViewModelType {
    //Input
    
    //Output
    var user: Driver<User?> { get }
}

final class HomeController: UIViewController, ViewType {

    var viewModel: HomeViewModelBindable!
    var disposeBag: DisposeBag!
    
    private let mapView = MKMapView()
    private let route = MKRoute()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = appearance
    }
    
    func setupUI() {
        configureMapView()
        
        // logout
        AuthManager.shared.doLogout()
            .subscribe { completable in
                switch completable {
                case .completed:
                    print("Successfully logged out")
                case .error(let err):
                    print("Failed to logout", err)
                }
            }
            .disposed(by: disposeBag)

    }
    
    func configureMapView() {
        view.addSubview(mapView)
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.followWithHeading, animated: true)
    }
    
    func bind() {
        
    }
    

}
