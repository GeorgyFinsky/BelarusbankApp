//
//  FacilityType.swift
//  BelarusbankApp
//
//  Created by Georgy Finsky on 29.01.23.
//

import Foundation
import UIKit
import GoogleMaps

enum FacilityType: String, CaseIterable {
    case atm = "ATM"
    case department = "Departmnt"
    case all = "All"
    
    var markerIcon: UIImage {
        return GMSMarker.markerImage(with: markerColor)
    }
    
    private var markerColor: UIColor {
        switch self {
            case .atm: return UIColor.green
            case .department: return UIColor.yellow
            default: return UIColor.red
        }
    }
    
}
