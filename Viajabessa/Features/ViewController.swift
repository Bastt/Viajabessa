//
//  ViewController.swift
//  Viajabessa
//
//  Created by Ronilson on 07/05/2018.
//  Copyright © 2018 Ronilson Batista. All rights reserved.
//

import UIKit
import Alamofire


class ViewController: UIViewController {
    
    var service = PacksService()
    var packs: [PacksModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.service.getTravelPackages(success: { result  in

            if result.count == 0 {
                return
            }
            self.packs = result
            print("Total de Pacotes: \(self.packs.count)")
            print("Nome do primeiro pacote \(String(describing: self.packs.first?.section))")
            print("Todos os pacotes: \(result)")

        }) { error in
        }

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

