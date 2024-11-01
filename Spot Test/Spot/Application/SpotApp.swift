//
//  SpotApp.swift
//  Spot
//
//  Created by Taras Tomchuk.
//  Copyright MIT Licence 2024 All rights reserved.
//

import SwiftUI

@main
struct SpotApp: App {
    
    init() {
        AppAppearanceConfigurator.configureNavigationBarAppearance()
    }
    
    var body: some Scene {
        WindowGroup {
            AppRootView()
                .preferredColorScheme(.light)
        }
    }
}
