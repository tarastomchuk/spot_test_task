//
//  TokensListUseCase.swift
//  Spot
//
//  Created by Taras Tomchuk.
//  Copyright MIT Licence 2024 All rights reserved.
//

import Foundation

protocol TokensListUseCaseProtocol {
    
    /// Fetches the list of tokens.
    /// - Returns: A `Tokens` array containing `Token` objects.
    func getTokensList() async throws -> Tokens
}
