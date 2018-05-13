//
//  TravelPackagesDetailPresenter.swift
//  Viajabessa
//
//  Created by Ronilson on 12/05/2018.
//  Copyright © 2018 Ronilson Batista. All rights reserved.
//

import UIKit
import RealmSwift

final class TravelPackagesDetailPresenter {
    
    fileprivate unowned let view: TravelPackagesDetailProtocol
    
    init(view: TravelPackagesDetailProtocol) {
        self.view = view
    }
}

// MARK: - Public methods
extension TravelPackagesDetailPresenter {
    
    func setupInitializerView() {
        self.view.setup()
        self.view.setAttributesView()
    }
    
    func savingTravelPackagesToCart(travelPackage: TravelPackageModel?) {
        
        let realm = try! Realm()
        try! realm.write {
            let database = TravelPackageDatabase()
            guard let travelPackages = travelPackage else {
                return
            }
            database.name = travelPackages.title!
            database.price = travelPackages.price!
            database.travelPackageDescription = travelPackages.documents!
            database.image = travelPackages.image!
            realm.add(database)
        }
    }
}
