//
//  TravelPackagesDetailController.swift
//  Viajabessa
//
//  Created by Ronilson on 12/05/2018.
//  Copyright © 2018 Ronilson Batista. All rights reserved.
//

import UIKit

class TravelPackagesDetailController: UITableViewController {
    
    @IBOutlet fileprivate weak var containerButtonView: UIView!
    @IBOutlet fileprivate weak var containerShadowButtonView: UIView!
    @IBOutlet fileprivate weak var containerMoreInfoView: UIView!
    @IBOutlet fileprivate weak var containerShadowMoreInfoView: UIView!
    @IBOutlet fileprivate weak var travelPackageMoreInfoImage: UIImageView!
    @IBOutlet fileprivate weak var travelPackageArrowImage: UIImageView!
    @IBOutlet fileprivate weak var travelPackageMoreInfoButton: UIButton!
    @IBOutlet fileprivate weak var travelPackageName: UILabel!
    @IBOutlet fileprivate weak var travelPackagePrice: UILabel!
    @IBOutlet fileprivate weak var travelPackageDaily: UILabel!
    @IBOutlet fileprivate weak var travelPackagePerson: UILabel!
    @IBOutlet fileprivate weak var travelPackageLocation: UILabel!
    @IBOutlet fileprivate weak var travelPackageImage: UIImageView!
    
    var travelPackage: TravelPackageModel?
    fileprivate var presenter: TravelPackagesDetailPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = TravelPackagesDetailPresenter(view: self)
        self.presenter.setupInitializerView()
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
}

// MARK: - Table view data source

extension TravelPackagesDetailController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
}

// MARK: - UIStoryboardSegue

extension TravelPackagesDetailController {
    override internal func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "travelPackagesPurchase":
                if let travelPackagesPurchase = segue.destination as? TravelPackagesPurchaseController {
                    travelPackagesPurchase.travelPackageModel = travelPackage
                }
            case "moreInfo":
                if let travelPackagesPurchase = segue.destination as? TravelPackagesDetailMoreInfoController {
                    travelPackagesPurchase.travelPackageModel = travelPackage
                }

            default: print("Identifier \(identifier) isn't a valid segue")
            }
        }
    }
}

// MARK: - Action methods

extension TravelPackagesDetailController {
    
    @IBAction func moreInfo(_ sender: UIButton) {
        
    }

}

// MARK: - ViewProtocol

extension TravelPackagesDetailController: TravelPackagesDetailProtocol {

    func setup() {
        guard let travelPackage = self.travelPackage else { return  }
        
        self.travelPackageName.text = travelPackage.title
        self.travelPackagePrice.text = travelPackage.price
        self.travelPackageLocation.text = travelPackage.location
        self.travelPackageDaily.text = travelPackage.daily
        self.travelPackagePerson.text = travelPackage.person
        
        if let imageString = travelPackage.image, let imageURL = URL(string: imageString) {
            travelPackageImage!.af_setImage(withURL: imageURL)
        }
    }
    
    func setAttributesView() {
 
        self.travelPackageMoreInfoButton.titleLabel?.textColor = AppColor.shared.colorPrimary
         self.travelPackageArrowImage.image = self.travelPackageArrowImage.image?.overlayImage(AppColor.shared.colorPrimary)
         self.travelPackageMoreInfoImage.image = self.travelPackageMoreInfoImage.image?.overlayImage(AppColor.shared.colorPrimary)
        ButtonViewParameterization.cornerRadius(view: self.containerButtonView)
        ButtonViewParameterization.shadowView(view: self.containerShadowButtonView, color: AppColor.shared.colorPrimary)
        ButtonViewParameterization.cornerRadius(view: self.containerMoreInfoView)
        ButtonViewParameterization.shadowView(view: self.containerShadowMoreInfoView, color: UIColor.white)

    }
}
