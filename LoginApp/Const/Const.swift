//
//  Const.swift
//  LoginApp
//
//  Created by Sanjay Shah on 03/01/2021.
//  Copyright © 2021 Solution Analysts. All rights reserved.
//

import Foundation

let AppName     = "Login App"
let Base_URL    = "http://imaginato.mocklab.io"

enum Const {
    enum Error {
        static let validEmail       = "This is a invalid email."
        static let validPassword    = "Passwords require at least 1 uppercase, 1 lowercase, and 1 number."
        static let dateFormatError  = "Date string does not match format expected by formatter."
    }
    
    enum Success {
        static let loginSuccess     = "You have logged in successfully."
    }
    
    enum Keys {
        static let email            = "email"
        static let password         = "password"
        static let xacc             = "X-Acc"
        static let user             = "user"
        static let createdAt        = "created_at"
    }
}
