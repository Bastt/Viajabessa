//
//  TravelPackagesPaymentHistoryController.swift
//  Viajabessa
//
//  Created by Ronilson on 12/05/2018.
//  Copyright © 2018 Ronilson Batista. All rights reserved.
//

import UIKit
import RealmSwift

class TravelPackagesPaymentHistoryController: UITableViewController {
    
    fileprivate var presenter: TravelPackagesPaymentHistoryControllerPresenter!
    fileprivate var dataBase: Realm?
    fileprivate var productDb: RealmSwift.Results<TravelPackageDatabase>?
    fileprivate let rowHeightEmpty: CGFloat = 500
    fileprivate let rowHeightBuy: CGFloat = 240
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataBase = try! Realm()
        
        self.presenter = TravelPackagesPaymentHistoryControllerPresenter(view: self)
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white, NSAttributedStringKey.font : UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight.semibold)]
        self.navigationController?.navigationBar.barTintColor = AppControl.shared.colorPrimary
        
        self.tableView.register(UINib(nibName: PaymentHistoryCell.identifier, bundle: nil), forCellReuseIdentifier: PaymentHistoryCell.identifier)
        self.tableView.register(UINib(nibName: WithoutViewCell.identifier, bundle: nil), forCellReuseIdentifier: WithoutViewCell.identifier)
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        tabBarItem = UITabBarItem(title: "histórico", image: UIImage(named: "shopping-icon"), tag: 1)
        self.tabBarController?.tabBar.backgroundColor = UIColor.white
        self.tabBarController?.tabBar.tintColor =  AppControl.shared.colorPrimary
        self.tabBarController?.tabBar.unselectedItemTintColor = UIColor.black
    }
    override func viewWillAppear(_ animated: Bool) {
        self.presenter.setupInitializerView()
    }
}

// MARK: - Table view data source

extension TravelPackagesPaymentHistoryController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @objc fileprivate func goBack(){ self.navigationController?.popViewController(animated: false) }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let buy = self.productDb else { return 0 }
        if buy.count == 0 { return rowHeightEmpty }
        return rowHeightBuy
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let buy = self.productDb else { return 0 }
        if buy.count == 0 { return 1 }
        return buy.count
    }
    
    internal override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let buy = self.productDb else { return UITableViewCell() }
        if buy.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: WithoutViewCell.identifier, for: indexPath) as! WithoutViewCell
            cell.setCellAttributes(txtWithout: "Nenhuma compra foi realizada.", image: UIImage(named: "sad")!)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: PaymentHistoryCell.identifier, for: indexPath) as! PaymentHistoryCell
            cell.setContent(savePayment: buy[indexPath.row])
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(white: 1, alpha: 0.5)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
            
        if self.productDb?.count == 0 {
           return
        } else {
            guard let purchases = self.productDb, let dataBase = self.dataBase else { return }
            if (editingStyle == UITableViewCellEditingStyle.delete) {
                try! dataBase.write {dataBase.delete(purchases[indexPath.item])}
                updateData()
            }
        }
    }
}

// MARK: - ViewProtocol

extension TravelPackagesPaymentHistoryController: TravelPackagesPaymentHistoryControllerProtocol {
    
    
    func addRightBarButtonItems() {
        let cleanItem = UIBarButtonItem(title: "Deletar", style: .plain, target: self, action: #selector(self.cleanPurchases))
        cleanItem.tintColor = .white
        self.navigationItem.setRightBarButtonItems([cleanItem], animated: true)
    }
    
    @objc func cleanPurchases() {
        if self.productDb?.count == 0 {
            Alert.show(delegate: self, title: ";)", message: "Nenhuma compra realizada", buttonTitle: "OK") { _ in }
        }else {
            Alert.show(delegate: self, title: "Deletar todas as compras?", message: "Você tem certeza que deseja apagar todas as compras.", buttonTitle: "OK", hasChoice: true) { choice in
                if choice {
                    guard let dataBase = self.dataBase else {
                        return
                    }
                    try! dataBase.write {
                        dataBase.deleteAll()
                    }
                    self.updateData()
                }
            }
        }
    }

    func updateData() {
        guard let dataBase = self.dataBase else { return }
        productDb = dataBase.objects(TravelPackageDatabase.self)
        tableView.reloadData()
    }
}
