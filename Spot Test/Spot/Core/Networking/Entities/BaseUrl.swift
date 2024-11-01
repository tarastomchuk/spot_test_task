//
//  BaseUrl.swift
//  Spot
//
//  Created by Taras Tomchuk.
//  Copyright MIT Licence 2024 All rights reserved.
//

import Foundation

// Base url builder with respect to current environment
public struct BaseUrl {
    
    public static var components: URLComponents {
        let currentEnvironment = EnvironmentProvider.current
        var urlComponents = URLComponents()
        
        urlComponents.scheme = currentEnvironment.scheme
        urlComponents.host = currentEnvironment.baseApiUrl
        urlComponents.path = "/\(currentEnvironment.apiVersion)"
        
        return urlComponents
    }
}
