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

protocol HomeViewModelBindable: ViewModelType {
    //Input
    
    //Output
    var user: Driver<User?> { get }
    
    
}

class HomeController: UIViewController, ViewType {

    var viewModel: HomeViewModelBindable!
    var disposeBag: DisposeBag!
    
    private let mapView = MKMapView()
    private let route = MKRoute()
    private let locationHandler = LocationHandler.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
    func setupUI() {
        
    }
    
    func bind() {
        
    }
    

}
