//
//  TokensListViewModel.swift
//  Spot
//
//  Created by Taras Tomchuk.
//  Copyright MIT Licence 2024 All rights reserved.
//

import SwiftUI
import Foundation

@MainActor
class TokensListViewModel: ObservableObject {
    
    // MARK: - Injections -
    
    @Injected private var tokensListUseCase: TokensListUseCaseProtocol
    
    // MARK: - Published Properties -
    
    @Published var tokens: [TokenDetails] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    // MARK: - Properties -
    
    private var sourceTokens: Tokens = []
    
    // MARK: - Methods -
    
    /// Fetches the list of tokens from the use case.
    func getTokensList() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let tokensList = try await tokensListUseCase.getTokensList()
            self.sourceTokens = tokensList
            self.tokens = mapTokensToDetails(tokensList)
            self.isLoading = false
        } catch let networkError as NetworkError {
            self.errorMessage = networkError.description
            self.isLoading = false
        } catch {
            self.errorMessage = NetworkError.unexpected(message: error.localizedDescription).description
            self.isLoading = false
        }
    }
    
    /// Sorts the tokens based on the selected sorting option.
    /// - Parameter option: The sorting option chosen by the user.
    func sortTokens(by option: SortingOption) {
        switch option {
        case .byPriceAscending:
            sourceTokens.sort { $0.price < $1.price }
        case .byPriceDescending:
            sourceTokens.sort { $0.price > $1.price }
        case .alphabetical:
            sourceTokens.sort { $0.name.lowercased() < $1.name.lowercased() }
        }
        
        tokens = mapTokensToDetails(sourceTokens)
    }
}

// MARK: - Private -

private extension TokensListViewModel {
    
    /// Maps an array of `Token` objects to an array of `TokenDetails` for UI consumption.
    /// - Parameter tokens: The array of `Token` objects to map.
    /// - Returns: An array of `TokenDetails`.
    func mapTokensToDetails(_ tokens: Tokens) -> [TokenDetails] {
        return tokens.map { token in
            let priceFormatted = formatPrice(token.price)
            
            return TokenDetails(
                name: token.name,
                symbol: token.symbol,
                price: priceFormatted,
                logo: token.logoURI
            )
        }
    }
    
    // Custom Formatter of price to handle really small values
    func formatPrice(_ price: Decimal) -> String {
        let priceString = NSDecimalNumber(decimal: price).stringValue
        let components = priceString.split(separator: ".")
        let decimalPart = components.count > 1 ? components[1] : ""
        
        var nonZeroDigits = ""
        var leadingZeros = 0
        
        for digit in decimalPart {
            if digit != "0" {
                nonZeroDigits.append(digit)
                if nonZeroDigits.count == 2 {
                    break
                }
            } else {
                if nonZeroDigits.isEmpty {
                    leadingZeros += 1
                }
            }
        }
        
        let wholePartIsZero = components.first == "0"
        
        let formattedPrice: String
        if wholePartIsZero {
            // Construct the output with leading zeros and the first two non-zero digits
            let leadingZerosString = String(repeating: "0", count: leadingZeros)
            
            formattedPrice = "0." + leadingZerosString + nonZeroDigits.prefix(2)
        } else {
            // If the whole part is not zero, return it as is with the first two non-zero digits
            formattedPrice = "\(components.first!).\(nonZeroDigits.prefix(2))"
        }
        
        return "$ \(formattedPrice)"
    }
}
