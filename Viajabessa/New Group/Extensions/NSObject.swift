//
//  NSObject.swift
//  Viajabessa
//
//  Created by Ronilson on 09/05/18.
//  Copyright © 2018 Ronilson Batista. All rights reserved.
//

import UIKit

protocol Identifying { }

extension Identifying where Self : NSObject {
    
    static var identifier: String { return String(describing: self) }
}

extension NSObject: Identifying { }
