//
//  TravelPackagesDetailPresenter.swift
//  Viajabessa
//
//  Created by Ronilson on 12/05/2018.
//  Copyright © 2018 Ronilson Batista. All rights reserved.
//

import UIKit

final class TravelPackagesDetailPresenter {
    
    fileprivate unowned let view: TravelPackagesDetailProtocol
    
    init(view: TravelPackagesDetailProtocol) {
        self.view = view
    }
}

// MARK: - Public methods
extension TravelPackagesDetailPresenter {
    
    func setupInitializerView() {
        self.view.setup()
        self.view.setAttributesView()
    }
}
