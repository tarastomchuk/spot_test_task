//
//  TokensListView.swift
//  Spot
//
//  Created by Taras Tomchuk.
//  Copyright MIT Licence 2024 All rights reserved.
//

import SwiftUI

struct TokensListView: View {
    
    // MARK: - Properties -
    
    @StateObject private var viewModel = TokensListViewModel()
    @State private var showingSortOptions = false
    
    // MARK: - UI -
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    loadingView
                } else if let errorMessage = viewModel.errorMessage {
                    errorView(errorMessage)
                } else {
                    VStack {
                        headerTitles
                        tokensList
                    }
                }
            }
            .navigationBarTitle(
                AppTexts.ListView.appName,
                displayMode: .inline
            )
            .navigationBarItems(
                leading: filterButton
            )
            .actionSheet(isPresented: $showingSortOptions) {
                sortActionSheet
            }
        }
        .onAppear {
            Task {
                await viewModel.getTokensList()
            }
        }
    }
}

// MARK: - Private -

private extension TokensListView {
    
    var loadingView: some View {
        ProgressView(AppTexts.ListView.loadingList)
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity
            )
            .font(.custom(
                AppFonts.AvenirMedium,
                size: 17)
            )
    }
    
    func errorView(_ message: String) -> some View {
        VStack(spacing: 16) {
            Text(message)
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .padding()
            
            Button(action: {
                Task {
                    await viewModel.getTokensList()
                }
            }) {
                Text(AppTexts.ListView.retryButton)
                    .font(.custom(
                        AppFonts.AvenirHeavy,
                        size: 17)
                    )
                    .foregroundColor(.white)
                    .padding()
                    .background(AppColors.buttonBackground)
                    .cornerRadius(10)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    var headerTitles: some View {
        HStack {
            Text(AppTexts.ListView.tokens.uppercased())
                .font(.custom(
                    AppFonts.AvenirMedium,
                    size: 12)
                )
                .foregroundColor(AppColors.mainText)
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
            
            Text(AppTexts.ListView.price.uppercased())
                .font(.custom(
                    AppFonts.AvenirMedium,
                    size: 12)
                )
                .foregroundColor(AppColors.mainText)
                .frame(
                    maxWidth: .infinity,
                    alignment: .trailing
                )
        }
        .padding(.horizontal)
        .padding(.top, 24)
        .padding(.bottom, 8)
        .background(AppColors.listBackground)
    }
    
    var filterButton: some View {
        Button(action: {
            showingSortOptions = true
        }) {
            HStack {
                Image(AppImages.filter)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 15)
                
                Text(AppTexts.ListView.sortButton)
                    .font(.custom(
                        AppFonts.AvenirHeavy,
                        size: 17)
                    )
                    .foregroundColor(AppColors.mainText)
            }
        }
    }
    
    var tokensList: some View {
        List(viewModel.tokens) { token in
            TokenRow(
                name: token.name,
                symbol: token.symbol,
                price: token.price,
                logo: token.logo
            )
            .listRowSeparator(.hidden)
            .listRowInsets(
                EdgeInsets(
                    top: 8,
                    leading: 16,
                    bottom: 8,
                    trailing: 16
                )
            )
        }
        .listStyle(PlainListStyle())
    }
    
    var sortActionSheet: ActionSheet {
        ActionSheet(
            title: Text(AppTexts.ListView.sortingTitle),
            buttons: SortingOption.allCases.map { option in
                .default(Text(option.description)) {
                    viewModel.sortTokens(by: option)
                }
            } + [.cancel()]
        )
    }
}
