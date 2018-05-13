//
//  TravelPackagesPurchaseProtocol.swift
//  Viajabessa
//
//  Created by Ronilson on 12/05/2018.
//  Copyright © 2018 Ronilson Batista. All rights reserved.
//

import Foundation

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
