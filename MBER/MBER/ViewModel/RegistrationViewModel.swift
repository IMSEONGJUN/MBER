//
//  RegistrationViewModel.swift
//  MBER
//
//  Created by SEONGJUN on 2020/10/02.
//

import Foundation
import RxSwift
import RxCocoa
import Firebase

typealias Register = (email: String, fullName: String, userType: String, password: String)

struct RegistrationViewModel: RegistrationViewModelBindable {
    
    // MARK: - Properties
    let email = PublishRelay<String>()
    let fullName = PublishRelay<String>()
    let userType = PublishRelay<String>()
    let password = PublishRelay<String>()
    let signupButtonTapped = PublishRelay<Void>()
    let goToLoginPageButtonTapped = PublishRelay<Void>()
    
    let isRegistering: Driver<Bool>
    let isRegistered: Signal<Bool>
    let isFormValid: Driver<Bool>
    
    var disposeBag = DisposeBag()
    
    
    // MARK: - Initializer
    init(_ model: AuthManager = .shared) {
        // Proxy
        let onRegistering = PublishRelay<Bool>()
        isRegistering = onRegistering.asDriver(onErrorJustReturn: false)
        let onRegistered = PublishRelay<Bool>()
        isRegistered = onRegistered.asSignal(onErrorJustReturn: false)
        
        // Validate Registration Values
        let registrationValues = Observable
            .combineLatest(
                email,
                fullName,
                userType,
                password
            )
            .share()
        
        isFormValid = registrationValues
            .map {
                isValidEmailAddress(email: $0)
                && $1.count > 2
                && $3.count > 6
            }
            .asDriver(onErrorJustReturn: false)
        
        // Register
        signupButtonTapped
            .withLatestFrom( registrationValues )
            .do(onNext: { _ in
                onRegistering.accept(true)
            })
            .flatMapLatest( model.performRegistration )
            .subscribe(onNext: {
                onRegistering.accept(false)
                onRegistered.accept($0)
            })
            .disposed(by: disposeBag)
    }
}
