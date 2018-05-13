//
//  PaymentHistoryCell.swift
//  Viajabessa
//
//  Created by Ronilson on 13/05/2018.
//  Copyright © 2018 Ronilson Batista. All rights reserved.
//

import UIKit

class PaymentHistoryCell: UITableViewCell {
    
    @IBOutlet weak var travelPackageName: UILabel!
    @IBOutlet weak var travelPackagePrice: UILabel!
    @IBOutlet weak var travelPackageDaily: UILabel!
    @IBOutlet weak var travelPackageLocation: UILabel!
    @IBOutlet weak var travelPackagePerson: UILabel!
    @IBOutlet weak var travelPackageimages: UIImageView!

    func setContent(savePayment: TravelPackageDatabase) {
        
        self.travelPackageName.text = savePayment.name
        self.travelPackagePrice.text = savePayment.price
        self.travelPackageLocation.text = savePayment.location
        self.travelPackagePerson.text = savePayment.person
        self.travelPackageDaily.text = savePayment.daily
        
        self.travelPackageName.font = UIFont.boldSystemFont(ofSize: 16)
        self.travelPackagePrice.font = UIFont.boldSystemFont(ofSize: 14)
        self.travelPackageLocation.font = UIFont.boldSystemFont(ofSize: 20)
        
        if let data = savePayment.image as? Data {
            self.travelPackageimages.image = UIImage(data: data)
        }
    }
}
