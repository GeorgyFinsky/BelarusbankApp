//
//  GemModel.swift
//  BelarusbankApp
//
//  Created by Georgy Finsky on 29.01.23.
//

import Foundation

struct GemModel: Decodable {
    var attestatID: String = ""
    var form: String = ""
    var facetCount: String = ""
    var weight: String = ""
    var color: String = ""
    var price: String = ""
    var filialID: String = ""
    
    enum CodingKeys: String, CodingKey {
        case attestatID = "attestat"
        case form = "name_ru"
        case facetCount = "grani"
        case weight = "weight"
        case color = "color"
        case price = "cost"
        case filialID = "filial_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        attestatID = try container.decode(String.self, forKey: .attestatID)
        form = try container.decode(String.self, forKey: .form)
        facetCount = try container.decode(String.self, forKey: .facetCount)
        weight = try container.decode(String.self, forKey: .weight)
        color = try container.decode(String.self, forKey: .color)
        price = try container.decode(String.self, forKey: .price)
        filialID = try container.decode(String.self, forKey: .filialID)
    }
    
}
