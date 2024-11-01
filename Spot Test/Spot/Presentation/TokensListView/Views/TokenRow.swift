//
//  TokenRow.swift
//  Spot
//
//  Created by Taras Tomchuk.
//  Copyright MIT Licence 2024 All rights reserved.
//

import SwiftUI
import Kingfisher

struct TokenRow: View {
    
    // MARK: - Properties -
    
    let name: String
    let symbol: String
    let price: String
    let logo: String
    
    // MARK: - UI -
    
    var body: some View {
        HStack(
            spacing: 12
        ) {
            tokenLogoImage(logo: logo)
            
            VStack(
                alignment: .leading,
                spacing: 4
            ) {
                nameText(name: name)
                symbolText(symbol: symbol)
            }
            
            Spacer()
            
            priceText(price: price)
                .layoutPriority(1)
        }
        .padding()
        .background(AppColors.listBackground)
        .cornerRadius(20)
        .frame(height: 80)
    }
}

private extension TokenRow {
    
    func tokenLogoImage(logo: String) -> some View {
        KFImage(URL(string: logo))
            .placeholder {
                Image(AppImages.tokenImagePlaceholder)
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: 50,
                        height: 50
                    )
                    .foregroundColor(.gray)
            }
            .retry(
                maxCount: 3,
                interval: .seconds(3)
            )
            .resizable()
            .scaledToFit()
            .frame(
                width: 50,
                height: 50
            )
            .cornerRadius(25)
    }
    
    func nameText(name: String) -> some View {
        Text(name)
            .font(Font.custom(
                AppFonts.AvenirHeavy,
                size: 18)
            )
            .foregroundColor(AppColors.mainText)
    }
    
    func symbolText(symbol: String) -> some View {
        Text(symbol)
            .font(Font.custom(
                AppFonts.AvenirMedium,
                size: 16)
            )
            .foregroundColor(AppColors.mainText.opacity(0.8))
    }
    
    func priceText(price: String) -> some View {
        Text(price)
            .font(Font.custom(
                AppFonts.AvenirBlack,
                size: 18)
            )
            .foregroundColor(AppColors.mainNumber)
    }
}
