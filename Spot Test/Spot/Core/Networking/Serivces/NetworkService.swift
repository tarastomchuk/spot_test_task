//
//  NetworkService.swift
//  Spot
//
//  Created by Taras Tomchuk.
//  Copyright MIT Licence 2024 All rights reserved.
//

import Foundation

final class NetworkService: NetworkServiceProtocol {
    
    // MARK: - Injections -
    
    @Injected private var networkRequestService: NetworkClientManagerProtocol
    
    // MARK: - Properties -
    
    private lazy var encoder = JSONEncoder()
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return decoder
    }()
    
    // MARK: - Request -
    
    func request<Input: Encodable, Output: Decodable>(
        configuration: NetworkRequestConfiguration,
        input: Input,
        responseType: Output.Type
    ) async throws -> Output {
        let parameters: [String: Any]? = try {
            let dictionary = try encodeToDictionary(input)
            return dictionary.isEmpty ? nil : dictionary
        }()
        
        do {
            let dataResponse = try await networkRequestService.request(
                configuration: configuration,
                parameters: parameters,
                responseType: responseType,
                decoder: decoder
            )
            
            return dataResponse
        } catch let networkError as NetworkError {
            throw networkError
        } catch {
            throw NetworkError.unexpected(message: error.localizedDescription)
        }
    }
}

// MARK: - Private -

private extension NetworkService {
    
    func encodeToDictionary<T: Encodable>(_ value: T) throws -> [String: Any] {
        let data = try encoder.encode(value)
        let dictionary = try JSONSerialization.jsonObject(
            with: data,
            options: []
        ) as? [String: Any]
        
        return dictionary ?? [:]
    }
}
