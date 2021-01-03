//
//  LoginViewModel.swift
//  LoginApp
//
//  Created by Sanjay Shah on 03/01/2021.
//  Copyright © 2021 Solution Analysts. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    // MARK: - Variables
    var email = BehaviorRelay(value: "")
    var password = BehaviorRelay(value: "")
    var needLogin = PublishSubject<Void>()
    var emailValid: Driver<Bool>
    var passwordValid: Driver<Bool>
    var emailPasswordValid: Driver<Bool>
    var userRes = PublishSubject<UserRes>()
    var disposeBag = DisposeBag()
    let showLoading = BehaviorRelay<Bool>(value: false)
    
    // MARK: - init()
    init() {
        emailValid = email
            .asDriver()
            .map({ $0.isValidEmail() })
        
        passwordValid = password
            .asDriver()
            .map({ $0.isValidPassword() })
        
        emailPasswordValid = Driver.combineLatest(
            email.asDriver(),
            emailValid,
            passwordValid
        ) { email, emailValid, passwordValid in
            return !email.isEmpty()
                && emailValid
                && passwordValid
        }
        
        let params = Driver.combineLatest(
            email.asDriver(),
            password.asDriver()
        ) { (email: $0, password: $1) }
        
        needLogin
            .do(onNext: {
                self.showLoading.accept(true)
            })
            .withLatestFrom(params)
            .flatMapLatest { [unowned self] (email, password) in
                self.logIn(email: email, password: password)
                    .catchError { error in
                        return Observable.empty()
                }
        }
        .bind(to: userRes)
        .disposed(by: disposeBag)
    }
}

// MARK: - Login API Call With Rx
extension LoginViewModel {
    func logIn(email: String, password: String) -> Observable<UserRes> {
        return Observable.create { observer in
            authService
                .rx
                .request(.login(email: email, password: password))
                .subscribeOn(MainScheduler.instance)
                .filterSuccessfulStatusCodes()
                .do(onSuccess: { (res) in },
                    afterSuccess: { (res) in
                        self.showLoading.accept(false)
                        let httpHeaders = res.response?.allHeaderFields as? [String: Any]
                        // Save User Token into Preference
                        Helper.shared.saveToken(httpHeaders: httpHeaders)
                        // Get User Token into Preference
                        // let token = Helper.shared.getToken()
                }, onError: { (error) in
                    self.showLoading.accept(false)
                })
                .map(UserRes.self, failsOnEmptyData: false)
                .subscribe(onSuccess: { (results) in
                    observer.onNext(results)
                    observer.onCompleted()
                }) { (error) in
                    print(error.localizedDescription)
            }
        }.delaySubscription(DispatchTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
    }
}
