//
//  NetworkClientManagerProtocol.swift
//  Spot
//
//  Created by Taras Tomchuk.
//  Copyright MIT Licence 2024 All rights reserved.
//

import Foundation

protocol NetworkClientManagerProtocol {
    
    func request<Output: Decodable>(
        configuration: NetworkRequestConfiguration,
        parameters: [String: Any]?,
        responseType: Output.Type,
        decoder: JSONDecoder
    ) async throws -> Output
}
