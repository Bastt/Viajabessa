//
//  TravelPackagesPaymentHistoryControllerPresenter.swift
//  Viajabessa
//
//  Created by Ronilson on 12/05/2018.
//  Copyright © 2018 Ronilson Batista. All rights reserved.
//

import Foundation

final class TravelPackagesPaymentHistoryControllerPresenter {
    
    fileprivate unowned let view: TravelPackagesPaymentHistoryControllerProtocol
    
    init(view: TravelPackagesPaymentHistoryControllerProtocol) {
        self.view = view
        self.setupInitializerView()
    }
}

// MARK: - Public methods

extension TravelPackagesPaymentHistoryControllerPresenter {
    
    func setupInitializerView() {
        self.view.updateData()
        self.view.addRightBarButtonItems()
    }
}
