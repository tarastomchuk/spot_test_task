//
//  AppConfigs.swift
//  Spot
//
//  Created by Taras Tomchuk.
//  Copyright MIT Licence 2024 All rights reserved.
//

import Foundation

// This is just basic example, to demonstrate idea behind App Configurations
/// Goal of this file is to substitute .xcodeconfig files, but simulate similar behaviour

struct AppConfigs {
    
    static var devBaseApiUrl: String {
        return "google.com"
    }
    static var prodBaseApiUrl: String {
        return "spot-labs.github.io"
    }
    
    static var devScheme: String {
        return "http"
    }
    static var prodScheme: String {
        return "https"
    }
    
    // Just for example, sometimes we have different api versions
    static var devApiVersion: String {
        return "v2"
    }
    static var prodApiVersion: String {
        return "ios-interview-api"
    }
}
