//
//  TravelPackagesCollectionViewCell.swift
//  Viajabessa
//
//  Created by maciosdev on 09/05/18.
//  Copyright © 2018 Ronilson Batista. All rights reserved.
//

import UIKit
import AlamofireImage

class TravelPackagesCollectionCell: UICollectionViewCell {
    
    @IBOutlet fileprivate weak var title: UILabel!
    @IBOutlet fileprivate weak var location: UILabel!
    @IBOutlet fileprivate weak var price: UILabel!
    @IBOutlet fileprivate weak var daily: UILabel!
    @IBOutlet fileprivate weak var person: UILabel!
    @IBOutlet fileprivate weak var image: UIImageView!
    
    func setup(travelPackages: TravelPackageModel) {
        
        self.title.text = travelPackages.title
        self.location.text = travelPackages.location
        self.price.text = travelPackages.price
        self.daily.text = travelPackages.daily
        self.person.text = travelPackages.person
        
        if let imageString = travelPackages.image, let imageURL = URL(string: imageString) {
            image!.af_setImage(withURL: imageURL)
        }
        
        self.title.font = UIFont.boldSystemFont(ofSize: 18)
        self.location.font = UIFont.boldSystemFont(ofSize: 18)
    }
}

