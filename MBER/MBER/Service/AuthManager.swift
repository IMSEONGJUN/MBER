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
import Firebase
import FirebaseFirestore

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
    
    // MARK: - Registration Logic
    func performRegistration(values: Register) -> Completable {
        return Completable.create { (observer) -> Disposable in
            Auth.auth().createUser(withEmail: values.email, password: values.password) { (result, error) in
                if let error = error {
                    print("failed to create User: ", error)
                    observer(.error(error))
                    return
                }
                self.saveInfoToFirestore(values: values)
                    .subscribe(onCompleted: {
                        observer(.completed)
                    }, onError: { (err) in
                        observer(.error(err))
                    })
                    .disposed(by: self.disposeBag)
            }
            return Disposables.create()
        }
        
    }
    
    private func saveInfoToFirestore(values: Register) -> Completable {
        let uid = Auth.auth().currentUser?.uid ?? ""
        
        let docData:[String: Any] = [
            "email": values.email,
            "fullname": values.fullName,
            "userType": values.userType,
            "uid": uid,
        ]
        
        return Completable.create { (observer) -> Disposable in
            Firestore.firestore().collection("users").document(uid).setData(docData) { (error) in
                if let error = error {
                    print("failed to save user Info: ", error)
                    observer(.error(error))
                    return
                }
                observer(.completed)
            }
            return Disposables.create()
        }
    }

    
}
