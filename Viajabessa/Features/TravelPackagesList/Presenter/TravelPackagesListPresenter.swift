//
//  TravelPackagesListPresenter.swift
//  Viajabessa
//
//  Created by Ronilson on 08/05/18.
//  Copyright © 2018 Ronilson Batista. All rights reserved.
//

import Foundation

final class TravelPackagesListPresenter {

    fileprivate unowned let view: TravelPackagesListProtocol
    fileprivate let service: PacksService
    fileprivate(set) var packs: [PacksModel] = []

    init(view: TravelPackagesListProtocol) {
        self.view = view
        self.service = PacksService()
    }
}

// MARK: - Public methods

extension TravelPackagesListPresenter {
    
    func loadTravelPackages() {
        self.view.startLoading()
        self.service.getTravelPackages(success: { result  in
            
            if result.count == 0 { return }
            
            self.packs = result
            print("Total de Pacotes: \(self.packs.count)")
            print("Nome do primeiro pacote \(String(describing: self.packs.first?.section))")
            print("location: \(String(describing: self.packs.first?.travelPackage?.first?.location))")
            print("Todos os pacotes: \(result)")
            self.view.reloadTableView()
            self.view.stopLoading()
            
        }) { error in
            self.requestError(errorDescription: error)
        }
    }
}

// MARK: - Private methods

extension TravelPackagesListPresenter {
    
    fileprivate func requestError(errorDescription: String) {
        self.view.stopLoading()
        self.view.showAlertError(with: "Erro", message: errorDescription, buttonTitle: "OK")
    }
}
