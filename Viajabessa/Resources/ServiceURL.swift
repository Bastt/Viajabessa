//
//  ServiceURL.swift
//  Viajabessa
//
//  Created by Ronilson on 08/05/18.
//  Copyright © 2018 Ronilson Batista. All rights reserved.
//

import Foundation

enum ServiceURL {
    case travelPackage
    
    var value: String {
        switch self {
        case .travelPackage: return "https://private-e3bd8d-desafiomobicaretwo.apiary-mock.com/desafioMobicareTwo"
        }
    }
}
