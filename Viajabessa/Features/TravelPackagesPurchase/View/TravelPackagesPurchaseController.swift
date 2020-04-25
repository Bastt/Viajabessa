//
//  TravelPackagesPurchaseController.swift
//  Viajabessa
//
//  Created by Ronilson on 12/05/2018.
//  Copyright © 2018 Ronilson Batista. All rights reserved.
//

import UIKit
import AlamofireImage
import RealmSwift

class TravelPackagesPurchaseController: UITableViewController {
    
    @IBOutlet fileprivate weak var containerButtonView: UIView!
    @IBOutlet fileprivate weak var containerShadowButtonView: UIView!
    @IBOutlet fileprivate weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var locationLabel: UILabel!
    @IBOutlet fileprivate weak var dailyLabel: UILabel!
    @IBOutlet fileprivate weak var personLabel: UILabel!
    @IBOutlet fileprivate weak var priceLabel: UILabel!
    @IBOutlet fileprivate weak var imageProduct: UIImageView!
    @IBOutlet fileprivate weak var nomeProdCell: UITableViewCell!
    @IBOutlet fileprivate weak var userNameCell: UITableViewCell!
    @IBOutlet fileprivate weak var CardNumberCell: UITableViewCell!
    @IBOutlet fileprivate weak var CvvCell: UITableViewCell!
    @IBOutlet fileprivate weak var nameTextField: UITextField!
    @IBOutlet fileprivate weak var cvvTextField: VSTextField!
    @IBOutlet fileprivate weak var cardNumberTextField: VSTextField!
    @IBOutlet fileprivate weak var cardValidationTextField: VSTextField!
    
    var travelPackageModel: TravelPackageModel?
    fileprivate var presenter: TravelPackagesPurchasePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = TravelPackagesPurchasePresenter(view: self)
        self.presenter.setupInitializerView()
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
}

// MARK: - Table view data source
extension TravelPackagesPurchaseController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
}

// MARK: - Action
extension TravelPackagesPurchaseController {

    @IBAction func payment(_ sender: AnyObject) {
        
        if checkFields() {
            self.presenter.savingTravelPackagesToCart(travelPackage: self.travelPackageModel, imageView: self.imageProduct)
            Alert.show(delegate: self, title: "Compra Finalizada", message: "Sua compra foi finalizada com sucesso") { _ in
                self.navigationController?.popToRootViewController(animated: true)
            }
            self.resetField()
        } else {
            Alert.show(delegate: self, title: "Preenchar todos os campos", message: "Para efetuar uma compra você precisa preencher todos os campos", buttonTitle: "Tente novamente") { _ in }
        }
    }
}

// MARK: - ViewProtocol
extension TravelPackagesPurchaseController: TravelPackagesPurchaseProtocol {

    func setup() {
        guard let travelPackage = self.travelPackageModel else { return }
        
        self.nameLabel.text = travelPackage.title
        self.locationLabel.text = travelPackage.location
        self.dailyLabel.text = travelPackage.daily
        self.personLabel.text = travelPackage.person
        self.priceLabel.text = travelPackage.price
        
        if let imageString = travelPackage.image, let imageURL = URL(string: imageString) {
            imageProduct!.af_setImage(withURL: imageURL)
        }
    }
    
    func addDoneButton() {
        let keyboardToolbar = UIToolbar(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 0, height: 44)))
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "closeDown"), style: UIBarButtonItem.Style.done, target: view, action: #selector(UIView.endEditing(_:)))
        
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        
        cardNumberTextField.inputAccessoryView = keyboardToolbar
        cvvTextField.inputAccessoryView = keyboardToolbar
        cardValidationTextField.inputAccessoryView = keyboardToolbar
    }
    
    func resetField() {
        nameTextField.text = ""
        cardNumberTextField.text = ""
        cardValidationTextField.text = ""
        cvvTextField.text = ""
    }
    
    func checkFields() -> Bool {
        
        self.tintCell()
        
        guard let name = self.nameTextField.text, let number = self.cardNumberTextField.text, let cvv = self.cvvTextField.text, let year = self.cardValidationTextField.text else {
            return false
        }
        
        if name.count >= 2, number.count == 16, year.count == 4, cvv.count >= 3 { return true }
        else {return false }
    }
    
    func tintCell() {
        guard let name = self.nameTextField.text, let number = self.cardNumberTextField.text, let cvv = self.cvvTextField.text, let year = self.cardValidationTextField.text else {
            return
        }
        
        let errorColor = AppColor.shared.colorError
        
        if name.count < 2 { userNameCell.backgroundColor = errorColor }
        else { userNameCell.backgroundColor = .clear }
        if number.count < 16 { CardNumberCell.backgroundColor = errorColor }
        else { CardNumberCell.backgroundColor = .clear }
        if year.count < 4 { CvvCell.backgroundColor = errorColor }
        else if cvv.count < 3 { CvvCell.backgroundColor = errorColor }
        else { CvvCell.backgroundColor = .clear }
    }
    
    
    func setAttributesView() {
        ButtonViewParameterization.cornerRadius(view: self.containerButtonView)
        ButtonViewParameterization.shadowView(view: self.containerShadowButtonView, color: AppColor.shared.colorPrimary)
    }
    
    func setupView() {
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func VSTextField() {
        self.cardNumberTextField.setFormatting("#### #### #### ####", replacementChar: "#")
        self.cardValidationTextField.setFormatting("##/##", replacementChar: "#")
        self.cvvTextField.setFormatting("###", replacementChar: "#")
    }
    
    func dismiss() {
         guard let travelPackage = self.travelPackageModel else { return }
        Alert.show(delegate: self, title: "Pacote adicionado", message: "O Pacote \(travelPackage.title!) foi com comprado com sucesso") { _ in
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}
