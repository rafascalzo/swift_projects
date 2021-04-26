//
//  NewButtonViewController.swift
//  Full Square
//
//  Created by Fulltrack Mobile on 13/08/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//
import MapKit
import UIKit

class NewButtonViewController: UIViewController {
    
    typealias CustomView = NewButtonView
    
    let cellId = "cellId"
    let device = UIDevice.current.userInterfaceIdiom
    let initialImages = ["hostpital-building","home","ambulance","gamepad-console","shopping-cart"]
    let disciplineOptions = ["film","ticket","beaker","medical-kit","credit-card","anchor","umbrella","beer","music","cocktail","volume-up","android","apple","barcode","bell","bitcoin-logo","leaves","briefcase","bug","building-front","fire-extinguisher","bull-horn","bullseye","camera-retro","plane","flag","coffee-cup","truck","ball","doctor","eye-open","stethoscope","heart","linux-logo","fire-symbol","hotel","html-5-logo","paper-bill","instagram","telephone","legal-hammer","female-silhouette","fighter-jet","flag2","fork-and-knife","lemon","light-bulb","lightning-bolt","link","sun","wheelchair","rocket","mobile","tint-drop","trophy","open-laptop","wrench","plant","puzzle","suitcase","turkish","dashboard","desktop-monitor"]
    
    var customView : CustomView {
        if let view = self.view as? CustomView{
            view.delegate = self
            return view
        } else {
            let view = CustomView()
            view.delegate = self
            self.view = view
            return view
        }
    }
    
    var reloadTableDelegate : ReloadTableViewDelegate?
    
    let debounce = Debouncer(timeInterval: 0.5)
    var placemark : CLPlacemark?
    func renewInterval() -> Void {
        debounce.renewInterval()
    }
    
    fileprivate func setupCollectionView() {
        
        customView.buttonsCollectionView.delegate = self
        customView.buttonsCollectionView.dataSource = self
        customView.buttonsCollectionView.register(ButtonsCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        customView.buttonTitleTextField.delegate = self
        //addTapGesture(in: customView)
        // Do any additional setup after loading the view.
    }
}

extension NewButtonViewController : NewButtonViewDelegate {
    func saveButton(_ sender: Any) {
        saveSettings()
    }
    
//    func handleImageView(_ sender : Any) {
//        customView.addCollection()
//        customView.showCollection()
//    }
    
    func backToPreviousController(_ sender: Any) {
        if let navigation = navigationController {
            navigation.popViewController(animated: true)
        }
    }
    
    func saveSettings() {
        let uuid = NSUUID().uuidString
        let newID = UUID(uuidString: uuid)
        let title = customView.buttonTitleTextField.text!
        let imageName: String = customView.imageView.accessibilityIdentifier!
        
        if Validation.isTextFieldsEmpty(textFields: customView.textFields){
            let button = ButtonModel(id: newID!, title: title, imageName: imageName)
            print(button.id)
            print(button.title)
            print(button.imageName)
            ButtonDAO().saveButton(button)
            reloadTableDelegate?.reloadTable()
            let controller = NewMarkerViewController()
            controller.placemark = self.placemark
            if let navigation = navigationController {
                navigation.popViewController(animated: true)
            }
        }else{
            let alert = Alert(controller: self)
            alert.showOkOption("Invalid submit", message: "Please fill all fields") {
                //
            }
        }
    }
  
    func handleTapGesture(_ sender : Any){
        customView.endEditing(true)
    }
} 

extension NewButtonViewController : UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return disciplineOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ButtonsCollectionViewCell
        let name = disciplineOptions[indexPath.row]
        cell.setupCell(name, margin: 35)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return device == .phone ? CGSize(width: ((UIScreen.main.bounds.width / 4) - (CGFloat.paddingSmall * 3)), height: ((UIScreen.main.bounds.width / 4) - (CGFloat.paddingSmall * 3))) : CGSize(width: ((UIScreen.main.bounds.width / 6) - (CGFloat.paddingSmall * 5)), height: ((UIScreen.main.bounds.width / 6) - (CGFloat.paddingSmall * 5)))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ButtonsCollectionViewCell
        print(cell.name)
        print((cell.image.image!))
        let row = indexPath.row
        self.customView.imageView.image = cell.image.image
        self.customView.imageView.accessibilityIdentifier = "\(disciplineOptions[row])"
        
       // self.customView.removeCollection()
    }
}
extension NewButtonViewController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("test")
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        renewInterval()

        debounce.handler = {
            self.customView.buttonTitleTextField = textField
        }
        print("dsadsdsf")
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.customView.endEditing(true)
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        renewInterval()
        
        debounce.handler = {
            print("test")
        }
        return true
    }
}
