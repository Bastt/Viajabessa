//
//  Packs.swift
//  Viajabessa
//
//  Created by Ronilson on 08/05/18.
//  Copyright © 2018 Ronilson Batista. All rights reserved.
//

import Foundation

struct PacksModel : Codable {
    
    let id: Int?
    let section: String?
    let detail: String?
    let travelPackage: [TravelPackageModel]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case section
        case detail
        case travelPackage = "pacotes"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try values.decodeIfPresent(Int.self, forKey: .id)
        self.section = try values.decodeIfPresent(String.self, forKey: .section)
        self.detail = try values.decodeIfPresent(String.self, forKey: .detail)
        self.travelPackage = try values.decode([TravelPackageModel].self, forKey: .travelPackage)
    }
}
