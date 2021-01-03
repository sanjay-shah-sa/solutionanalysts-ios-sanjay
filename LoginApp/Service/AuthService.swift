//
//  AuthService.swift
//  LoginApp
//
//  Created by Sanjay Shah on 03/01/2021.
//  Copyright © 2021 Solution Analysts. All rights reserved.
//

import Foundation
import Moya

let authService = MoyaProvider<AuthService>(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))])

enum AuthService {
    case login(email: String, password: String)
}

extension AuthService: TargetType {
    var path: String {
        switch self {
        case .login:
            return "/login"
        }
    }

    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }

    var parameters: [String : Any] {
        switch self {
        case .login(let email, let password):
            return [Const.Keys.email: email,
                    Const.Keys.password: password]
        }
    }

    var task: Task {
        return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
    }
}
