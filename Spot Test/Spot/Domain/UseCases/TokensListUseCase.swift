//
//  TokensListUseCase.swift
//  Spot
//
//  Created by Taras Tomchuk.
//  Copyright MIT Licence 2024 All rights reserved.
//

import Foundation

class TokensListUseCase: TokensListUseCaseProtocol {
    
    // MARK: - Injections -
    
    @Injected private var networkService: NetworkServiceProtocol
    
    // MARK: - Methods -
    
    func getTokensList() async throws -> Tokens {
        let requestConfig = NetworkRequestConfiguration(endpoint: .tokens)
        
        do {
            let tokenResponse: TokenResponse = try await networkService.request(
                configuration: requestConfig,
                responseType: TokenResponse.self
            )
            
            return tokenResponse.tokens
        } catch {
            throw error
        }
    }
}
