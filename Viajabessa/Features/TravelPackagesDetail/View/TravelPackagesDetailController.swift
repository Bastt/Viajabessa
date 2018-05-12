//
//  TravelPackagesDetailController.swift
//  Viajabessa
//
//  Created by Ronilson on 12/05/2018.
//  Copyright © 2018 Ronilson Batista. All rights reserved.
//

import UIKit

class TravelPackagesDetailController: UITableViewController {
    
    @IBOutlet fileprivate weak var travelPackageName: UILabel!
    @IBOutlet fileprivate weak var travelPackagePrice: UILabel!
    @IBOutlet fileprivate weak var travelPackageDescription: UILabel!
    @IBOutlet fileprivate weak var travelPackageImage: UIImageView!
    
    var travelPackage: TravelPackageModel?
    fileprivate var presenter: TravelPackagesDetailPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = TravelPackagesDetailPresenter(view: self)
        self.presenter.setupInitializerView()
    }
}

// MARK: - Table view data source

extension TravelPackagesDetailController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
}

// MARK: - ActionMethods

extension TravelPackagesDetailController {
    
    @IBAction func buttonTouched() {
        print("vamos salvar sua compra no cart.")
    }
}

// MARK: - ViewProtocol

extension TravelPackagesDetailController: TravelPackagesDetailProtocol {
    func setup() {
        guard let travelPackage = self.travelPackage else { return  }
        self.travelPackageName.text = travelPackage.title
        self.travelPackagePrice.text = travelPackage.price
        self.travelPackageDescription.text = travelPackage.schedule
        
        if let imageString = travelPackage.image, let imageURL = URL(string: imageString) {
            travelPackageImage!.af_setImage(withURL: imageURL)
        }
    }
    
    func setAttributesView() {
    }
}
