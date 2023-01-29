//
//  IngotModel.swift
//  BelarusbankApp
//
//  Created by Georgy Finsky on 29.01.23.
//

import Foundation

struct IngotModel: Decodable {
    var gold10SellPrice: String = ""
    var gold20SellPrice: String = ""
    var gold50SellPrice: String = ""
    var silver10SellPrice: String = ""
    var silver20SellPrice: String = ""
    var silver50SellPrice: String = ""
    var platinum10SellPrice: String = ""
    var platinum20SellPrice: String = ""
    var platinum50SellPrice: String = ""
    var filialID: String = ""
    
    enum CodingKeys: String, CodingKey {
        case gold10SellPrice = "ZOL_10_out"
        case gold20SellPrice = "ZOL_20_out"
        case gold50SellPrice = "ZOL_50_out"
        case silver10SellPrice = "SIL_10_out"
        case silver20SellPrice = "SIL_20_out"
        case silver50SellPrice = "SIL_50_out"
        case platinum10SellPrice = "PL_10_out"
        case platinum20SellPrice = "PL_20_out"
        case platinum50SellPrice = "PL_50_out"
        case filialID = "filial_id"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        gold10SellPrice = try container.decode(String.self, forKey: .gold10SellPrice)
        gold20SellPrice = try container.decode(String.self, forKey: .gold20SellPrice)
        gold50SellPrice = try container.decode(String.self, forKey: .gold50SellPrice)
        silver10SellPrice = try container.decode(String.self, forKey: .silver10SellPrice)
        silver20SellPrice = try container.decode(String.self, forKey: .silver20SellPrice)
        silver50SellPrice = try container.decode(String.self, forKey: .silver50SellPrice)
        platinum10SellPrice = try container.decode(String.self, forKey: .platinum10SellPrice)
        platinum20SellPrice = try container.decode(String.self, forKey: .platinum20SellPrice)
        platinum50SellPrice = try container.decode(String.self, forKey: .platinum50SellPrice)
        filialID = try container.decode(String.self, forKey: .filialID)
    }
    
}
