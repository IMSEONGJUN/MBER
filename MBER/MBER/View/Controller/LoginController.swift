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

final class LoginController: UIViewController, ViewType {
    
    // MARK: - Properties
    var disposeBag: DisposeBag!
    var viewModel: LoginViewModelBindable!
    
    private let titleLabel = AuthTitleLabel()
    private let emailInputContainer = InputContainerView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), textField: InputTextField(placeHolder: "Email"))
    private let passwordInputContainer = InputContainerView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: InputTextField(placeHolder: "Password"))
    private let loginButton = GeneralConfirmButton(title: "Login", color: #colorLiteral(red: 0.2256013453, green: 0.6298174262, blue: 0.9165520668, alpha: 1))
    private let goToSignUpPageButton = BottomButtonOnAuth(firstText: "Don't have an account? ", secondText: "Sign Up")
    private let gesture = UITapGestureRecognizer()
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.AuthViewBackGroundColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
//        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    // MARK: - Override
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    
    // MARK: - Initial Setup
    func setupUI() {
        emailInputContainer.inputText.keyboardType = .emailAddress
        passwordInputContainer.inputText.isSecureTextEntry = true
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            $0.centerX.equalToSuperview()
        }
        
        let stack = UIStackView(arrangedSubviews: [emailInputContainer, passwordInputContainer, loginButton])
        stack.axis = .vertical
        stack.spacing = 10
        stack.setCustomSpacing(20, after: passwordInputContainer)
        stack.arrangedSubviews.forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(50)
            }
        }
        
        view.addSubview(stack)
        stack.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        view.addSubview(goToSignUpPageButton)
        goToSignUpPageButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        view.addGestureRecognizer(gesture)
    }
    
    
    // MARK: - Automatic Binding
    func bind() {
        
        // Input -> ViewModel
        emailInputContainer.inputText.rx.text
            .orEmpty
            .distinctUntilChanged()
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)
        
        passwordInputContainer.inputText.rx.text
            .orEmpty
            .distinctUntilChanged()
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        loginButton.rx.tap
            .bind(to: viewModel.loginButtonTapped)
            .disposed(by: disposeBag)
        
        
        // ViewModel -> Output
        viewModel.isValidForm
            .drive(onNext: { [weak self] in
                self?.loginButton.isEnabled = $0
                self?.loginButton.backgroundColor = $0 ? #colorLiteral(red: 0.2256013453, green: 0.6298174262, blue: 0.9165520668, alpha: 1) : #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
            })
            .disposed(by: disposeBag)
        
        viewModel.isLoginCompleted
            .emit(onNext: { [weak self] _ in
                self?.showActivityIndicator(false)
                self?.switchToConversationVC()
            })
            .disposed(by: disposeBag)
        
        
        // UI binding
        loginButton.rx.tap
            .do(onNext: { [unowned self] _ in
                self.showActivityIndicator(true)
            })
            .bind(to: viewModel.loginButtonTapped)
            .disposed(by: disposeBag)
        
        goToSignUpPageButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                let vc = RegistrationController.create(with: RegistrationViewModel())
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
        
        gesture.rx.event
            .subscribe(onNext: { [unowned self] _ in
                self.view.endEditing(true)
            })
            .disposed(by: disposeBag)
    }
}
