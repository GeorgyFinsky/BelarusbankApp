//
//  NewsModel.swift
//  BelarusbankApp
//
//  Created by Georgy Finsky on 31.01.23.
//

import Foundation

struct NewsModel: Decodable, BankFacility {
    var title: String = ""
    var imageUrl: String = ""
    var text: String = ""
    var date: String = ""
    
    enum CodingKeys: String, CodingKey {
        case title = "name_ru"
        case imageUrl = "img"
        case text = "html_ru"
        case date = "start_date"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        imageUrl = try container.decode(String.self, forKey: .imageUrl)
        text = try container.decode(String.self, forKey: .text)
        date = try container.decode(String.self, forKey: .date)
    }
    
}
