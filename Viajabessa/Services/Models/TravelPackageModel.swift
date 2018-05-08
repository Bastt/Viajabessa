//
//  TravelPackageModel.swift
//  Viajabessa
//
//  Created by Ronilson on 08/05/18.
//  Copyright © 2018 Ronilson Batista. All rights reserved.
//

import Foundation

struct TravelPackageModel : Codable {
    
    let id: Int?
    let title: String?
    let location: String?
    let price: String?
    let image: String?
    let person: String?
    let daily: String?
    let documents: String?
    let schedule: String?
    let period: String?
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case title
        case location = "localizacao"
        case price
        case image
        case person
        case daily = "diarias"
        case documents = "documentos"
        case schedule = "agendar"
        case period = "periodo"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try values.decodeIfPresent(Int.self, forKey: .id)
        self.title = try values.decodeIfPresent(String.self, forKey: .title)
        self.location = try values.decodeIfPresent(String.self, forKey: .location)
        self.price = try values.decodeIfPresent(String.self, forKey: .price)
        self.image = try values.decodeIfPresent(String.self, forKey: .image)
        self.person = try values.decodeIfPresent(String.self, forKey: .person)
        self.daily = try values.decodeIfPresent(String.self, forKey: .daily)
        self.documents = try values.decodeIfPresent(String.self, forKey: .documents)
        self.schedule = try values.decodeIfPresent(String.self, forKey: .schedule)
        self.period = try values.decodeIfPresent(String.self, forKey: .period)
    }
}
