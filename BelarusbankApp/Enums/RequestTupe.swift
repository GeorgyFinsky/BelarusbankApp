//
//  RequestTupe.swift
//  BelarusbankApp
//
//  Created by Georgy Finsky on 31.01.23.
//

import Foundation
import RealmSwift

enum RequestTupe: String, PersistableEnum {
    case atms
    case departments
    case gems
    case ingots
    case news
}
