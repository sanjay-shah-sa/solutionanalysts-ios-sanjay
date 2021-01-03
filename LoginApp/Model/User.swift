//
//  User.swift
//  LoginApp
//
//  Created by Sanjay Shah on 03/01/2021.
//  Copyright © 2021 Solution Analysts. All rights reserved.
//

import Foundation

// MARK: - User Response Model
public struct UserRes: Codable {
    public var result: Int?
    public var errorMessage: String?
    public var data: UserData?
    
    private enum CodingKeys : String, CodingKey {
        case result, errorMessage = "error_message", data
    }
}

// MARK: - User Data Model
public struct UserData: Codable {
    public var user: User?
}

// MARK: - User Model
public struct User: Codable {
    public var userId: Int?
    public var userName: String?
    public var createdAt: Date?
    
    private enum CodingKeys : String, CodingKey {
        case userId, userName, createdAt = "created_at"
    }
    
    init() { }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dateString = try container.decode(String.self, forKey: .createdAt)
        let formatter = DateFormatter.iso8601Full
        if let date = formatter.date(from: dateString) {
            createdAt = date
        } else {
            throw DecodingError.dataCorruptedError(
                forKey: .createdAt,
                in: container,
                debugDescription: Const.Error.dateFormatError)
        }
        self.userId = try container.decode(Int.self, forKey: .userId)
        self.userName = try container.decode(String.self, forKey: .userName)
    }
}
