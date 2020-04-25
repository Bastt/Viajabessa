//
//  TravelPackagesPurchasePresenter.swift
//  Viajabessa
//
//  Created by Ronilson on 12/05/2018.
//  Copyright © 2018 Ronilson Batista. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit

protocol TravelPackagesPurchaseProtocol: class {
    
    func setup()
    func VSTextField()
    func addDoneButton()
    func resetField()
    func checkFields() -> Bool
    func tintCell()
    func dismiss()
    func setAttributesView()
}

final class TravelPackagesPurchasePresenter {
    
    fileprivate unowned let view: TravelPackagesPurchaseProtocol
    
    init(view: TravelPackagesPurchaseProtocol) {
        self.view = view
    }
}

// MARK: - Public methods
extension TravelPackagesPurchasePresenter {

    func setupInitializerView() {
        self.view.VSTextField()
        self.view.addDoneButton()
        self.view.setAttributesView()
        self.view.setup()
    }
    
    func savingTravelPackagesToCart(travelPackage: TravelPackageModel?, imageView: UIImageView) {
        
        let realm = try! Realm()
        guard let travelPackages = travelPackage else {
            return
        }
        try! realm.write {
            let database = TravelPackageDatabase()
            database.name = travelPackages.title!
            database.price = travelPackages.price!
            database.travelPackageDescription = travelPackages.documents!
            database.location = travelPackages.location!
            database.person = travelPackages.person!
            database.daily = travelPackages.daily!
            
            if let images = imageView.image {
                database.image = images.pngData() as NSData?
            }

            realm.add(database)
        }
        self.view.dismiss()
    }
}
