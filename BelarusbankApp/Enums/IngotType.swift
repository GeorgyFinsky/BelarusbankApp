//
//  IngotType.swift
//  BelarusbankApp
//
//  Created by Georgy Finsky on 29.01.23.
//

import Foundation

enum IngotType: Int, CaseIterable {
    case gold = 0
    case silver = 1
    case platinum = 2
    
    var title: String {
        switch self {
            case .gold: return "Золото"
            case .silver: return "Серебро"
            case .platinum: return "Платина"
        }
    }
    
}
