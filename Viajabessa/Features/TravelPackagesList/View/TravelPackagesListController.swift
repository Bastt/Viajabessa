//
//  TravelPackagesListController.swift
//  Viajabessa
//
//  Created by maciosdev on 08/05/18.
//  Copyright © 2018 Ronilson Batista. All rights reserved.
//

import UIKit
import SVProgressHUD

class TravelPackagesListController: UITableViewController {
    
    fileprivate var presenter: TravelPackagesListPresenter!
    fileprivate var sectionHeight = CGFloat(40)
    fileprivate var itemSelect : (TravelPackageModel)?
        
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.presenter = TravelPackagesListPresenter(view: self)
        self.presenter.loadTravelPackages()
        self.presenter.setupInitializerView()
    }
}

// MARK: - UITableViewDataSource

extension TravelPackagesListController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.presenter.packs.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: sectionHeight))
        header.backgroundColor = .white
        
        let title = UILabel(frame: CGRect(x: 10, y: 0, width: view.frame.width - (10 * 2), height: header.bounds.height))
        title.text = self.presenter.packs[section].section
        title.font = UIFont.boldSystemFont(ofSize: 16)
        title.textColor = UIColor.darkGray
        header.addSubview(title)
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.sectionHeight
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell : TravelPackagesViewCell = tableView.dequeueReusableCell(withIdentifier: TravelPackagesViewCell.identifier, for: indexPath) as! TravelPackagesViewCell
        cell.delegate = self
        cell.setContent(travelPackage: self.presenter.packs[indexPath.section].travelPackage!)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 199
    }
}

// MARK: - ViewProtocol

extension TravelPackagesListController: TravelPackagesListProtocol {
    
    func navigationItem() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white, NSAttributedStringKey.font : UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight.semibold)]
        self.navigationController?.navigationBar.barTintColor = AppControl.shared.colorPrimary
    }
    
    func tabBarItem() {
        tabBarItem = UITabBarItem(title: "destaques", image: UIImage(named: "star"), tag: 0)
        self.tabBarController?.tabBarItem.title = "destaques"
        self.tabBarController?.tabBar.backgroundColor = UIColor.white
        self.tabBarController?.tabBar.tintColor = AppControl.shared.colorPrimary
        self.tabBarController?.tabBar.unselectedItemTintColor = UIColor.black
    }
    
    func startLoading() {
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setForegroundColor(.white)
        SVProgressHUD.setBackgroundColor(UIColor.lightGray)
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show()
    }
    
    func stopLoading() {
        SVProgressHUD.dismiss()
    }
    
    func reloadTableView() {
        UIView.transition(with: tableView!, duration: 0.35, options: .transitionCrossDissolve, animations: {
            self.tableView?.reloadData()
        })
    }
    
    func showAlertError(with title: String, message: String, buttonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - SelectingCollection

extension TravelPackagesListController: SelectingCollection {
    
    func collectionSelected(travelPackage: TravelPackageModel) {
        let productSelected = "travelPackagesDetails"
        itemSelect = (travelPackage)
        performSegue(withIdentifier: productSelected, sender: nil)
    }
    
    // MARK: - Navigation

    override internal func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "travelPackagesDetails":
                if let travelPackageDetails = segue.destination as? TravelPackagesDetailController {
                    guard let select = itemSelect else {
                        return print("no itemSelect")
                    }
                    travelPackageDetails.travelPackage = select
                }
            default: print("Identifier \(identifier) isn't a valid segue")
            }
        }
    }
}
