//
//  ServiceManagerProtocol.swift
//  Viajabessa
//
//  Created by maciosdev on 08/05/18.
//  Copyright © 2018 Ronilson Batista. All rights reserved.
//

import Foundation

protocol ServiceManagerProtocol {
    
    func GetData(url: String, parameters: [String : Any]?, success: @escaping (Data) -> Void, failure: @escaping (ServiceError) -> Void)
    
}
