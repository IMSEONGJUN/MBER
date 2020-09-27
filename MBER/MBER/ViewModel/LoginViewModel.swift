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
    
    var isLoginCompleted: Signal<Bool>
    var isValidForm: Driver<Bool>
    
    init(_ model: AuthManager = AuthManager()) {
        
    }
}
