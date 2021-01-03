//
//  TargetType.swift
//  LoginApp
//
//  Created by Sanjay Shah on 03/01/2021.
//  Copyright © 2021 Solution Analysts. All rights reserved.
//

import Foundation
import Moya

extension TargetType {
    var baseURL: URL {
        guard let url = URL(string: Base_URL) else {
                assertionFailure("Unable to initialize login service URL")
                return URL.emptyURL()
        }

        return url
    }

    var headers: [String : String]? {
        var headerParam: [String: String] = [:]
        headerParam["Content-Type"] = "application/json"
        return headerParam
    }
    
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }

    var sampleData: Data {
        return Data()
    }
}
