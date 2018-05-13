//
//  ButtonViewParameterization.swift
//  Viajabessa
//
//  Created by Ronilson on 13/05/2018.
//  Copyright © 2018 Ronilson Batista. All rights reserved.
//

import UIKit

struct ButtonViewParameterization {
    
    static func cornerRadius(view: UIView) {
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.clipsToBounds = true
        view.layer.borderColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1).cgColor
    }
    
    static func shadowView(view: UIView, color: UIColor) {
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowColor = UIColor(red:0.45, green:0.45, blue:0.45, alpha:0.5).cgColor
        view.layer.shadowOpacity = 2
        view.layer.shadowRadius = 1
        view.layer.cornerRadius = 10
        view.backgroundColor = color
    }
}
