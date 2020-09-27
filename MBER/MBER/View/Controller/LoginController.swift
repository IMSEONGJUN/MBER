//
//  LoginController.swift
//  MBER
//
//  Created by SEONGJUN on 2020/09/27.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol LoginViewModelBindable: ViewModelType {
    // Input
    var email: BehaviorSubject<String> { get }
    var password: BehaviorSubject<String> { get }
    var loginButtonTapped: PublishRelay<Void> { get }
    
    // Output
    var isLoginCompleted: Signal<Bool> { get }
    var isValidForm: Driver<Bool> { get }
}

class LoginController: UIViewController, ViewType {
    
    // MARK: - Properties
    var disposeBag: DisposeBag!
    var viewModel: LoginViewModelBindable!
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "MBER"
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Light", size: 42)
        label.textColor = UIColor(white: 1, alpha: 0.8)
        return label
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.loginViewBackGround
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Initial Setup
    func setupUI() {
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Automatically Binding
    func bind() {
        <#code#>
    }
    
}
