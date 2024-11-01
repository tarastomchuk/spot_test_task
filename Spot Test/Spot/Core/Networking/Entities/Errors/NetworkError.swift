//
//  NetworkError.swift
//  Spot
//
//  Created by Taras Tomchuk.
//  Copyright MIT Licence 2024 All rights reserved.
//

import Foundation

// Just a sample of errors that we can have
enum NetworkError: Error {
    
    case unauthorised
    case invalidURL
    case requestFailed(Error)
    case decodingFailed
    case unexpectedStatusCode(Int)
    case noData
    case unexpected(message: String)
    case responseValidationFailed
    case custom(message: String)
    
    var description: String {
        switch self {
        case .unauthorised:
            return AppTexts.Errors.sessionExpired
            
        case .invalidURL:
            return AppTexts.Errors.invalidLink
            
        case .requestFailed:
            return AppTexts.Errors.clientRequestFailed
            
        case .decodingFailed:
            return AppTexts.Errors.parsingFailed
            
        case .unexpectedStatusCode:
            return AppTexts.Errors.serverDown
            
        case .noData:
            return AppTexts.Errors.missingData
            
        case .unexpected:
            return AppTexts.Errors.unknownFailure
            
        case .responseValidationFailed:
            return AppTexts.Errors.requestProcessingFail
            
        case .custom(message: let message):
            return message
            
        }
    }
}
