//
//  Alert.swift
//  Viajabessa
//
//  Created by Ronilson on 12/05/2018.
//  Copyright © 2018 Ronilson Batista. All rights reserved.
//

import UIKit

struct Alert {
    
    private init() {}
    
    static func show(delegate: AnyObject,title: String, message: String, buttonTitle: String? = nil, hasChoice: Bool? = nil, ok: @escaping (Bool) -> Void) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        var aux = buttonTitle
        if aux == nil { aux = "OK" }
        
        alert.addAction(UIAlertAction(title: aux, style: UIAlertAction.Style.default) {
            action in
            ok(true)
        })
        
        if let choice = hasChoice, choice {
            
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default) {
                action in
                ok(false)
            })
        }
        
        delegate.present(alert, animated: true, completion: nil)
    }
}
