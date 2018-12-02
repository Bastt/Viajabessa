//
//  TravelPackageDatabase.swift
//  Viajabessa
//
//  Created by Ronilson on 12/05/2018.
//  Copyright © 2018 Ronilson Batista. All rights reserved.
//

import UIKit
import RealmSwift

class TravelPackageDatabase: Object {
    
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var travelPackageDescription = ""
    @objc dynamic var price = ""
    @objc dynamic var image: NSData? = nil
    @objc dynamic var location = ""
    @objc dynamic var daily = ""
    @objc dynamic var person = ""
}
