//
//  TravelPackagesListProtocol.swift
//  Viajabessa
//
//  Created by Ronilson on 08/05/18.
//  Copyright © 2018 Ronilson Batista. All rights reserved.
//

import Foundation

protocol TravelPackagesListProtocol: class {

    func navigationItem()
    func tabBarItem()
    func startLoading()
    func stopLoading()
    func reloadTableView()
    func showAlertError(with title: String, message: String, buttonTitle: String)
}

