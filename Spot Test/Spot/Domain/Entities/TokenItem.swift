//
//  TokenItem.swift
//  Spot
//
//  Created by Taras Tomchuk.
//  Copyright MIT Licence 2024 All rights reserved.
//

import Foundation

// MARK: - Typealiases

typealias Tokens = [Token]

// MARK: - TokenResponse

struct TokenResponse: Codable {
    
    let tokens: Tokens
}

// MARK: - Token

struct Token: Codable {
    
    let liquidity: Double
    let extensions: Extensions?
    let logoURI: String
    let symbol: String
    let mc: Double
    let v24HUSD: Double
    let decimals: Int
    let price: Decimal
    let address: String
    let v24HChangePercent: Double
    let lastTradeUnixTime: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case liquidity, extensions, logoURI, symbol, mc
        case v24HUSD = "v24hUSD"
        case decimals, price, address
        case v24HChangePercent = "v24hChangePercent"
        case lastTradeUnixTime, name
    }
}

// MARK: - Extensions

struct Extensions: Codable {
    let description: String?
}
