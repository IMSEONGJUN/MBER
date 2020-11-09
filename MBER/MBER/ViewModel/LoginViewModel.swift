//
//  LoginViewModel.swift
//  MBER
//
//  Created by SEONGJUN on 2020/09/27.
//

import Foundation
import RxSwift
import RxCocoa

struct LoginViewModel: LoginViewModelBindable {
    var email = BehaviorSubject<String>(value: "")
    var password = BehaviorSubject<String>(value: "")
    var loginButtonTapped = PublishRelay<Void>()
    var goToRegisterButtonTapped = PublishRelay<Void>()
    
    var isLoginCompleted: Signal<Bool>
    var isValidForm: Driver<Bool>
    
    init(_ model: AuthManager = AuthManager()) {
        self.isValidForm = Observable
            .combineLatest(
                email,
                password
            )
            .map {
                isValidEmailAddress(email: $0)
                && $1.count > 6
            }
            .asDriver(onErrorJustReturn: false)
        
        isLoginCompleted = loginButtonTapped
            .withLatestFrom(
                Observable.combineLatest(email, password)
            )
            .flatMapLatest {
                model.performLogin(email: $0, password: $1)
            }
            .asSignal(onErrorJustReturn: false)
    }
}
