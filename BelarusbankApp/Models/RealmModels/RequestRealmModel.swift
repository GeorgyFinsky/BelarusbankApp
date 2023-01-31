//
//  RequestRealmModel.swift
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

class RequestRealmModel: Object {
    @Persisted var code = 2
    @Persisted var time = Date()
    @Persisted var type = RequestTupe.atms
    
    convenience init(code: Int, type: RequestTupe) {
        self.init()
        self.code = code
        self.type = type
    }
    
}
