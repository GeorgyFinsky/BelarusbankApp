//
//  AtmModel.swift
//  BelarusbankApp
//
//  Created by Georgy Finsky on 29.01.23.
//

import Foundation

struct ATMModel: Decodable, BankFacility {
    var id: String = ""
    var gpsX: String = ""
    var gpsY: String = ""
    var city: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case gpsX = "gps_x"
        case gpsY = "gps_y"
        case city = "city"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        gpsX = try container.decode(String.self, forKey: .gpsX)
        gpsY = try container.decode(String.self, forKey: .gpsY)
        city = try container.decode(String.self, forKey: .city)
    }
    
}
