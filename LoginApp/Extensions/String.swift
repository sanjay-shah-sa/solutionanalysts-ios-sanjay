//
//  String.swift
//  LoginApp
//
//  Created by Sanjay Shah on 03/01/2021.
//  Copyright © 2021 Solution Analysts. All rights reserved.
//

import Foundation

extension String {
    /// Check for String is Empty
    func isEmpty() -> Bool {
        return self.trimming().isEmpty
    }
    
    /// Check for Valid Email Address
    func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
    
    /// Check for Valid Password
    func isValidPassword() -> Bool {
        let passwordRegEx = "(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).{3,}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: self)
    }
    
    /// Return the string after trimming
    func trimming() -> String {
        let strText = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return strText
    }
}
