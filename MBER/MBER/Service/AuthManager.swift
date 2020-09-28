//
//  AuthManager.swift
//  MBER
//
//  Created by SEONGJUN on 2020/09/27.
//

import Foundation
import RxSwift
import RxCocoa
import FirebaseAuth

final class AuthManager {
    init() { }
    
    var disposeBag = DisposeBag()
    
    // MARK: - Login
    func performLogin(email: String, password: String) -> Observable<Bool> {
        Observable.create { (observer) -> Disposable in
            Auth.auth().signIn(withEmail: email, password: password) { (_, error) in
                if let error = error {
                    observer.onError(error)
                }
                observer.onNext(true)
            }
            
            return Disposables.create{
                observer.onCompleted()
            }
        }
    }
    
}
