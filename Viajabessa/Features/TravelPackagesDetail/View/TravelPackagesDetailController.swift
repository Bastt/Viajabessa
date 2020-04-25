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
    @IBOutlet fileprivate weak var travelPackageDaily: UILabel!
    @IBOutlet fileprivate weak var travelPackagePerson: UILabel!
    @IBOutlet fileprivate weak var travelPackageLocation: UILabel!
    @IBOutlet fileprivate weak var travelPeriodValid: UILabel!
    @IBOutlet fileprivate weak var travelSchedule: UILabel!
    @IBOutlet fileprivate weak var travelDocuments: UILabel!
    @IBOutlet fileprivate weak var travelPackageImage: UIImageView!

    var travelPackage: TravelPackageModel?
    fileprivate var presenter: TravelPackagesDetailPresenter!
    fileprivate var investButton : UIButton!

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
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {

        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 41))
        customView.backgroundColor = AppColor.shared.colorPrimary
        customView.layer.cornerRadius = 10.0
        customView.layer.shadowOpacity = 0.8
        customView.layer.shadowColor = AppColor.shared.colorSnow.cgColor
        customView.layer.shadowRadius = 3.0
        customView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 330, height: 50))
        button.setTitle("Ir para o pagamento", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel!.font = UIFont.systemFont(ofSize: 20.0, weight: UIFont.Weight.medium)
        button.addTarget(self, action: #selector(self.travelPackagesPurchase), for: .touchUpInside)
        customView.addSubview(button)
        
        return customView
    }
    
   override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
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

            default: print("Identifier \(identifier) isn't a valid segue")
            }
        }
    }
}

// MARK: - ViewProtocol
extension TravelPackagesDetailController: TravelPackagesDetailProtocol {
    @objc func travelPackagesPurchase() {
        let travelPackagesPurchase = "travelPackagesPurchase"
        performSegue(withIdentifier: travelPackagesPurchase, sender: nil)
    }

     func setup() {
        guard let travelPackage = self.travelPackage else { return  }
        
        self.travelPackageName.text = travelPackage.title
        self.travelPackagePrice.text = travelPackage.price
        self.travelPackageLocation.text = travelPackage.location
        self.travelPackageDaily.text = travelPackage.daily
        self.travelPackagePerson.text = travelPackage.person
        self.travelPeriodValid.text = travelPackage.period
        self.travelSchedule.text = travelPackage.schedule
        self.travelDocuments.text = travelPackage.documents
        
        if let imageString = travelPackage.image, let imageURL = URL(string: imageString) {
            travelPackageImage!.af_setImage(withURL: imageURL)
        }
    }
}
