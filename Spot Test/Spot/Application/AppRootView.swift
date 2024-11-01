//
//  AppRootView.swift
//  Spot
//
//  Created by Taras Tomchuk.
//  Copyright MIT Licence 2024 All rights reserved.
//

import SwiftUI

// AppRootView is a super-lightweight representation of Coordinator
struct AppRootView: View {
    
    // MARK: - Properties -
    
    @StateObject private var viewModel = AppRootViewViewModel()
    
    private let context: AppContextProtocol

    // MARK: - Life Cycle -
    
    init() {
        context = AppContext()
        context.configure()
    }
    
    // MARK: - UI -
    
    var body: some View {
        Group {
            switch viewModel.currentView {
            case .login:
                // Login or another auth screen should be here
                EmptyView()
            case .tokensList:
                TokensListView()
            }
        }
        .onAppear {
            viewModel.checkToken()
        }
    }
}

class AppRootViewViewModel: ObservableObject {

    // MARK: - Properties -
    
    @Published var currentView: AppRootViews = .login
    
    // MARK: - Logic -

    func checkToken() {
        // For example, we have auth logic and based on result switch screens
        
        currentView = .tokensList
    }
}
