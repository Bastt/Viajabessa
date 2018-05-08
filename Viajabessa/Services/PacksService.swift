//
//  PacksService.swift
//  Viajabessa
//
//  Created by Ronilson on 08/05/18.
//  Copyright © 2018 Ronilson Batista. All rights reserved.
//

import Foundation

final class PacksService {
    
    func getTravelPackages(success: @escaping (_ products: [PacksModel]) -> Void, fail: @escaping (_ error: String) -> Void) {
        
        ServiceManager.shared.GetData(url: ServiceURL.travelPackage.value, parameters: nil, success: { result in
            let response = try! JSONDecoder().decode([PacksModel].self, from: result)
            success(response)
        }, failure: { error in
            fail(error.description)
        })
    }
}
