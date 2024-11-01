//
//  AppAppearanceConfigurator.swift
//  Spot
//
//  Created by Taras Tomchuk.
//  Copyright MIT Licence 2024 All rights reserved.
//

import UIKit

struct AppAppearanceConfigurator {
    
    static func configureNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(AppColors.listBackground)
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor(AppColors.mainText),
            .font: UIFont(name: AppFonts.AvenirHeavy, size: 20) ?? UIFont.systemFont(ofSize: 20)
        ]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().tintColor = UIColor.blue
    }
}
