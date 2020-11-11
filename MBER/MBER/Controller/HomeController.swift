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

protocol HomeViewModelBindable: ViewModelType {
    
}

class HomeController: UIViewController, ViewType {

    var viewModel: HomeViewModelBindable!
    var disposeBag: DisposeBag!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
    func setupUI() {
        
    }
    
    func bind() {
        
    }
    

}
