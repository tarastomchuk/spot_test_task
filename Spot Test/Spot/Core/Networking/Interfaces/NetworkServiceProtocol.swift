//
//  NetworkServiceProtocol.swift
//  Spot
//
//  Created by Taras Tomchuk.
//  Copyright MIT Licence 2024 All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
    
    func request<
        Input: Encodable,
        Output: Decodable>(
            configuration: NetworkRequestConfiguration,
            input: Input,
            responseType: Output.Type
        ) async throws -> Output
}

extension NetworkServiceProtocol {
    
    func request<Output: Decodable>(
        configuration: NetworkRequestConfiguration,
        responseType: Output.Type
    ) async throws -> Output {
        return try await request(
            configuration: configuration,
            input: EmptyInput(),
            responseType: responseType
        )
    }
}
