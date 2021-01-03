//
//  Helper.swift
//  LoginApp
//
//  Created by Sanjay Shah on 03/01/2021.
//  Copyright © 2021 Solution Analysts. All rights reserved.
//

import Foundation

class Helper {
    static let shared = Helper()
    
    /// Save User Response into User Preference
    func saveUserData(userRes: UserRes) {
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()

            let formatter = DateFormatter.iso8601Full
            encoder.dateEncodingStrategy = .formatted(formatter)
            
            // Encode Note
            let data = try encoder.encode(userRes)

            // Write/Set Data
            UserDefaults.standard.set(data, forKey: Const.Keys.user)
        } catch {
            print("Unable to Encode User Data (\(error))")
        }
    }
    
    /// Get User Response from User Preference
    func getUserData() -> UserRes? {
        // Read/Get Data
        if let data = UserDefaults.standard.data(forKey: Const.Keys.user) {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()
                
                // Decode Note
                let userRes = try decoder.decode(UserRes.self, from: data)
                return userRes
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        }
        return nil
    }
    
    /// Save User Token into User Preference
    func saveToken(httpHeaders: [String: Any]?) {
        guard let headers = httpHeaders else { return }
        UserDefaults.standard.set(headers[Const.Keys.xacc], forKey: Const.Keys.xacc)
    }
    
    /// Get User Token into User Preference
    func getToken() -> String? {
        return UserDefaults.standard.value(forKey: Const.Keys.xacc) as? String
    }
}
