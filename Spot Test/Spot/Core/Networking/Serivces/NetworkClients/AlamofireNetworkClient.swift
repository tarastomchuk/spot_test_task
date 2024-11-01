//
//  AlamofireNetworkClient.swift
//  Spot
//
//  Created by Taras Tomchuk.
//  Copyright MIT Licence 2024 All rights reserved.
//

import Alamofire
import Foundation

final class AlamofireNetworkClient: NetworkClientManagerProtocol {
    
    // MARK: - Request -
    
    func request<Output: Decodable>(
        configuration: NetworkRequestConfiguration,
        parameters: [String: Any]?,
        responseType: Output.Type,
        decoder: JSONDecoder = JSONDecoder()
    ) async throws -> Output {
        let url = configuration.endpoint.url
        let method = adaptHTTPMethod(from: configuration.endpoint.httpMethod)
        let encoding = adaptEncoding(from: configuration.endpoint.encoding)
        let headers = adaptHeaders(from: configuration.headers)
        
        do {
            let dataResponse = await AF.request(
                url,
                method: method,
                parameters: parameters,
                encoding: encoding,
                headers: headers
            )
                .validate(statusCode: 200..<300)
                .serializingDecodable(responseType, decoder: decoder)
                .response
            
            print("🔍 Response Debug Description:\n\(dataResponse.debugDescription)")
            
            return try dataResponse.result.get()
            
        } catch let afError {
            switch afError {
            case .responseValidationFailed:
                throw NetworkError.responseValidationFailed
            case .invalidURL:
                throw NetworkError.invalidURL
            default:
                throw NetworkError.requestFailed(afError)
            }
        }
        
    }
}

// MARK: - Private -

private extension AlamofireNetworkClient {
    
    private func adaptHTTPMethod(from source: Spot.HTTPMethod) -> Alamofire.HTTPMethod {
        switch source {
        case .get:
            return .get
        case .post:
            return .post
        default:
            return .get
        }
    }
    
    private func adaptEncoding(from source: Spot.ParameterEncoding) -> Alamofire.ParameterEncoding {
        switch source {
        case .url:
            return URLEncoding.default
        case .json:
            return JSONEncoding.default
        }
    }
    
    private func adaptHeaders(from source: Spot.HTTPHeaders?) -> Alamofire.HTTPHeaders {
        var headers: Alamofire.HTTPHeaders = [:]
        guard let source = source else {
            return [:]
        }
        
        for (key, value) in source {
            headers.add(name: key, value: value)
        }
        
        return headers
    }
    
    private func handleAlamofireError(_ error: AFError) -> NetworkError {
        switch error {
        case .invalidURL(_):
            return .invalidURL
            
        case .responseSerializationFailed(_):
            return .decodingFailed
            
        case .sessionTaskFailed(let underlyingError):
            return .requestFailed(underlyingError)
            
        case .responseValidationFailed(let reason):
            switch reason {
            case .unacceptableStatusCode(let code):
                return .unexpectedStatusCode(code)
                
            default:
                return .responseValidationFailed
            }
            
        default:
            return .unexpected(message: "Unexpected error: \(error.localizedDescription)")
            
        }
    }
}
