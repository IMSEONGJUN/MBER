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

protocol HomeViewModelBindable: ViewModelType {
    
}

class HomeController: UIViewController, ViewType {

    var viewModel: HomeViewModelBindable!
    var disposeBag: DisposeBag!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
    func setupUI() {
        
    }
    
    func bind() {
        
    }
    

}
