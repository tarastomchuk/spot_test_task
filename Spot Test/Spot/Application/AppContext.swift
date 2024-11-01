//
//  AppContext.swift
//  Spot
//
//  Created by Taras Tomchuk.
//  Copyright MIT Licence 2024 All rights reserved.
//

import Foundation
import SwiftUI

protocol AppContextProtocol {
    
    func configure()
}

struct AppContext: AppContextProtocol {
    
    func configure() {
        registerDependencies()
    }
}

private extension AppContext {
    
    func registerDependencies() {
        registerNetworking()
        registerBusinessLogic()
    }
    
    func registerNetworking() {
        DIContainerService.shared.register(
            type: NetworkClientManagerProtocol.self,
            component: AlamofireNetworkClient()
        )
        DIContainerService.shared.register(
            type: NetworkServiceProtocol.self,
            component: NetworkService()
        )
    }

    func registerBusinessLogic() {
        DIContainerService.shared.register(
            type: TokensListUseCaseProtocol.self,
            component: TokensListUseCase()
        )
    }
}
