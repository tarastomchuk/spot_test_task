//
//  SortingOption.swift
//  Spot
//
//  Created by Taras Tomchuk.
//  Copyright MIT Licence 2024 All rights reserved.
//

import Foundation

enum SortingOption: CaseIterable, Identifiable {
    
    case alphabetical
    case byPriceAscending
    case byPriceDescending
    
    var id: SortingOption { self }
    
    var description: String {
        switch self {
        case .alphabetical:
            return AppTexts.ListView.alphabetical
            
        case .byPriceAscending:
            return AppTexts.ListView.byPriceAscending
            
        case .byPriceDescending:
            return AppTexts.ListView.byPriceDescending
            
        }
    }
}

