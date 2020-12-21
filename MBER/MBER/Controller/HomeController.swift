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
import MapKit
import SnapKit

protocol HomeViewModelBindable: ViewModelType {
    //Input
    var logoutButtonTapped: PublishRelay<Void> { get }
    
    //Output
    var user: Driver<User?> { get }
    var manager: CLLocationManager { get }
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
    }
    
    func configureMapView() {
        view.addSubview(mapView)
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }
    
    func bind() {
        viewModel.manager.rx.didChangeAuthorization
            .subscribe(onNext: { [weak self] in
                if $0.status == .authorizedWhenInUse {
                    self?.viewModel.manager.requestAlwaysAuthorization()
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.manager.rx.didUpdateLocations
            .subscribe(onNext:{ [weak self] in
                guard let current = $0.locations.last else { return }
                let coordinate = current.coordinate
                let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                self?.mapView.setRegion(region, animated: true)
            })
            .disposed(by: disposeBag)
    }
    

}



/*AuthManager.shared.doLogout()
    .subscribe { completable in
        switch completable {
        case .completed:
            print("Successfully logged out")
        case .error(let err):
            print("Failed to logout", err)
        }
    }
    .disposed(by: self.disposeBag)*/
