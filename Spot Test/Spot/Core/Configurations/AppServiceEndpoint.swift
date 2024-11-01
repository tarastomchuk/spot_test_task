//
//  AppServiceEndpoint.swift
//  Spot
//
//  Created by Taras Tomchuk.
//  Copyright MIT Licence 2024 All rights reserved.
//

import Foundation

// This is lightweight representation of url builder with default values for each endpoint

public enum AppServiceEndpoint: String {
    
    case login = "login" // just a sample
    case tokens = "data.json"
}

extension AppServiceEndpoint {
    
    var url: URLComponents {
        var components = BaseUrl.components
        
        components.path += "/\(self.rawValue)"
        
        return components
    }
    var httpMethod: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .tokens:
            return .get
        }
    }
    var encoding: ParameterEncoding {
        switch self {
        case .login, .tokens:
            return .json
        }
    }
}
