//
//  ServiceManager.swift
//  Viajabessa
//
//  Created by maciosdev on 08/05/18.
//  Copyright © 2018 Ronilson Batista. All rights reserved.
//

import Foundation
import Alamofire

final class ServiceManager: ServiceManagerProtocol {
    
    static let shared = ServiceManager()
    
    func GetData(url: String, parameters: [String : Any]?, success: @escaping (Data) -> Void, failure: @escaping (ServiceError) -> Void) {
        
        Alamofire.request(URL(string: url)!,
                          method: .get,
                          parameters: parameters)
            .validate()
            .responseData { (response) -> Void in
                
                guard response.result.isSuccess else {
                    failure(ServiceError(code: (response.response?.statusCode)!))
                    return
                }
                
                success(response.result.value!)
        }
    }
}
