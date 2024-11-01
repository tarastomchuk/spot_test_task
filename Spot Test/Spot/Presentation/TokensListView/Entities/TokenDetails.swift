//
//  TokenDetails.swift
//  Spot
//
//  Created by Taras Tomchuk.
//  Copyright MIT Licence 2024 All rights reserved.
//

import SwiftUI
import Foundation

struct TokenDetails: Identifiable {
    
    let id: String = UUID().uuidString
    let name: String
    let symbol: String
    let price: String
    let logo: String
}
