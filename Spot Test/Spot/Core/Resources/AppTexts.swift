//
//  AppTexts.swift
//  Spot
//
//  Created by Taras Tomchuk.
//  Copyright MIT Licence 2024 All rights reserved.
//

import Foundation

// Such kind of files usually should be generated using swift-gen for example together with localizations
struct AppTexts {
    
    struct ListView {
        static let appName = "Spot Tokens"
        
        static let tokens = "Tokens"
        static let price = "price"
        
        static let sortButton = "Sort"
        static let retryButton = "Try Again"
        
        static let loadingList = "Loading list"
        
        static let sortingTitle = "Options:"
        static let byPriceAscending = "Price: Low to High"
        static let byPriceDescending = "Price: High to Low"
        static let alphabetical = "Alphabetical"
        
        static let ok = "OK"
        
        static let unknownError = "Unknown error happened"
    }
    
    struct Errors {
        
        static let sessionExpired = "Your session has expired, please log in again"
        static let invalidLink = "Invalid request link. Please contact support."
        static let clientRequestFailed = "Client request error. Please try again or contact support."
        static let parsingFailed = "We're unable to read received data. Please try again."
        static let serverDown = "There was a server error. Please contact support."
        static let missingData = "No data received. Please contact support."
        static let unknownFailure = "Something went wrong\nTry again."
        static let requestProcessingFail = "There was error processing your request. Please try again or contact support."
    }
}
