//
//  TravelPackagesViewCell.swift
//  Viajabessa
//
//  Created by Ronilson on 09/05/18.
//  Copyright © 2018 Ronilson Batista. All rights reserved.
//

import UIKit

protocol SelectingCollection {
    func collectionSelected(travelPackage: TravelPackageModel)
}

class TravelPackagesViewCell: UITableViewCell {
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet fileprivate weak var collectionHeightConstraint: NSLayoutConstraint!
    
    var delegate: SelectingCollection?
    fileprivate var travelPackages = [TravelPackageModel]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setCollectionAttributes()
    }
    
    private func setCollectionAttributes() {
        self.collection.delegate = self
        self.collection.dataSource = self
    }
    
    func setContent(travelPackage: [TravelPackageModel]) {
        self.travelPackages = travelPackage
        self.collection.reloadData()
    }
}

// MARK: UICollectionViewDataSource
extension TravelPackagesViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.travelPackages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TravelPackagesCollectionCell.identifier, for: indexPath) as! TravelPackagesCollectionCell
        cell.setup(travelPackages: self.travelPackages[indexPath.row])
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension TravelPackagesViewCell:  UICollectionViewDelegate {
    internal func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let delegate = delegate else {
            print("SelectingCollection delegate not setted")
            return
        }
        delegate.collectionSelected(travelPackage: self.travelPackages[indexPath.row])
    }
}
