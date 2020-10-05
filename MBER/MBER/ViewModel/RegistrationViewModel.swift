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
    let memberType = PublishRelay<String>()
    let password = PublishRelay<String>()
    let signupButtonTapped = PublishRelay<Void>()
    
    let isRegistering: Driver<Bool>
    let isRegistered: Signal<Bool>
    let isFormValid: Driver<Bool>
    
    var disposeBag = DisposeBag()
    
    
    // MARK: - Initializer
    init(_ model: AuthManager = AuthManager()) {
        
        let onRegistering = PublishRelay<Bool>()
        isRegistering = onRegistering.asDriver(onErrorJustReturn: false)
        let onRegistered = PublishRelay<Bool>()
        isRegistered = onRegistered.asSignal(onErrorJustReturn: false)
        
        let registrationValues = Observable
            .combineLatest(
                email,
                fullName,
                memberType,
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
        
        signupButtonTapped
            .withLatestFrom( registrationValues )
            .do(onNext: { _ in
                onRegistering.accept(true)
            })
            .flatMapLatest( model.performRegistration )
            .subscribe(onNext: {
                onRegistering.accept(false)
                onRegistered.accept($0 ? true : false)
            })
            .disposed(by: disposeBag)
    }
}
