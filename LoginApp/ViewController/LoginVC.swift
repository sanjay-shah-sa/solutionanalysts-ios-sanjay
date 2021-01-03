//
//  LoginVC.swift
//  LoginApp
//
//  Created by Sanjay Shah on 03/01/2021.
//  Copyright © 2021 Solution Analysts. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class LoginVC: BaseVC {
    
    // MARK: - IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - Variables
    var viewModel = LoginViewModel()
    
    // MARK: - Class Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOnLoad()
        // Do any additional setup after loading the view.
    }
}

// MARK: - Setup On Load and Bind, Validate Methods
extension LoginVC {
    fileprivate func setupOnLoad() {
        // Test User Credentials
        // emailTextField.text = "test@imaginato.com"
        // passwordTextField.text = "Imaginato2020"
        bindViewModel()
        validate()
    }
    
    fileprivate func bindViewModel() {
        viewModel.showLoading
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe({ (showLoading) in
                self.view.endEditing(true)
                (showLoading.element ?? false) ? self.startAnimating() : self.stopAnimating()
            })
            .disposed(by: disposeBag)
        
        emailTextField.rx.text
            .orEmpty
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        loginButton.rx.tap
            .bind(to: viewModel.needLogin)
            .disposed(by: disposeBag)
        
        viewModel.userRes.subscribe(onNext: { user in
            if user.result == 1 {
                self.showMessage(title: AppName, message: Const.Success.loginSuccess)
                // Save User Data
                Helper.shared.saveUserData(userRes: user)
                // Get User Res
                // let userRes = Helper.shared.getUserData()
            } else {
                self.showMessage(title: AppName, message: user.errorMessage)
            }
        }).disposed(by: disposeBag)
    }
    
    fileprivate func validate() {
        emailTextField.rx
            .controlEvent(.editingDidEnd)
            .asDriver()
            .withLatestFrom(viewModel.emailValid)
            .drive(onNext: { [unowned self] isValid in
                self.emailErrorLabel.text = !isValid ? Const.Error.validEmail : ""
            })
            .disposed(by: disposeBag)
        
        passwordTextField.rx
            .controlEvent(.editingDidEnd)
            .asDriver()
            .withLatestFrom(viewModel.passwordValid)
            .drive(onNext: { [unowned self] isValid in
                self.passwordErrorLabel.text = !isValid ? Const.Error.validPassword : ""
            })
            .disposed(by: disposeBag)
        
        viewModel.emailPasswordValid
            .drive(onNext: { [unowned self] isValid in
                self.loginButton.isEnabled = isValid
                self.loginButton.alpha = isValid ? 1 : 0.5
            })
            .disposed(by: disposeBag)
    }
}
