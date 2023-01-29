//
//  DepartmentModel.swift
//  BelarusbankApp
//
//  Created by Georgy Finsky on 29.01.23.
//

import Foundation

struct DepartmentModel: Decodable, BankFacility {
    var id: String = ""
    var gpsX: String = ""
    var gpsY: String = ""
    var city: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id = "filial_id"
        case gpsX = "GPS_X"
        case gpsY = "GPS_Y"
        case city = "name"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        gpsX = try container.decode(String.self, forKey: .gpsX)
        gpsY = try container.decode(String.self, forKey: .gpsY)
        city = try container.decode(String.self, forKey: .city)
    }
    
}
