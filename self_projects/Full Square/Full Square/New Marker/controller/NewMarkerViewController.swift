//
//  NewMarkerViewController.swift
//  Full Square
//
//  Created by Fulltrack Mobile on 08/08/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//


import UIKit
import MapKit
class NewMarkerViewController: UIViewController {

    // MARK: - Attributtes
    typealias CustomView = ViewForm
    
    var customView: CustomView {
        if let view = self.view as? CustomView {
            view.delegate = self
            return view
        } else {
            let view = CustomView()
            view.delegate = self
            self.view = view
            return view
        }
    }
    
    var pickerData: [[String]] = [[String]]()
    var isOptionsVisible : Bool = false
    let tableViewCellId = "tableViewCellId"
    let imagePicker = ImagePicker()
    var placeMarks : [CLPlacemark] = []
    var placemark : CLPlacemark?
    var delegate : ReloadMainView?
    var disciplineOptions = [""]
    var buttonOptions : Array<Button>?
    var discipline : String?
    var ddi : String = "+55"
    var ddd : String = "11"
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadDisciplineOptions()
        setupPickerViewDelegate()
        
        pickerData = [["+55","+23"],
                      ["11", "14", "21", "15","17","23","12","18"]]
        
        customView.scrollView.delegate = self
    }
    fileprivate func setupPickerViewDelegate(){
        customView.telephonePickerView.delegate = self
        customView.telephonePickerView.dataSource = self
    }
    
    fileprivate func loadDisciplineOptions(){
        
        if buttonOptions != nil {
            disciplineOptions = []
            for i in 0...buttonOptions!.count - 1 {
                disciplineOptions.append(buttonOptions![i].imageName!)
            }
        }
        customView.listButtonTableView.reloadData()
    }
    
    fileprivate func setupButtonsTableView() {
        
        customView.listButtonTableView.delegate = self
        customView.listButtonTableView.dataSource = self
        customView.listButtonTableView.register(ListButtonTableViewCell.self, forCellReuseIdentifier: tableViewCellId)
    }
    
    fileprivate func setupTextFieldDelegate() {
        
        customView.textFieldTelephone.delegate = self
        customView.textFieldPlaceName.delegate = self
        customView.textFieldCategory.delegate = self
        customView.textFieldSite.delegate = self
    }
    
    fileprivate func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    fileprivate func setup() {
        setupImagePicker()
        setupButtonsTableView()
        setupTextFieldDelegate()
        //setupKeyboardNotifications()
    }
    
    func goTo(controller : UIViewController){
        if let navigation = navigationController{
            navigation.pushViewController(controller, animated: true)
        }
    }

    @objc func image(_ image : UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer){
        if let error = error {
            let alert = Alert(controller: self)
            alert.showOkOption("Error", message: "image not saved") {
                print(error.localizedDescription)
            }
        } else {
            let alert = Alert(controller: self)
            alert.showOkOption("Saved", message: "success") {
                //
            }
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.customView.frame.origin.y >= 0 {
                self.customView.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.customView.frame.origin.y != 0 {
            self.customView.frame.origin.y = 0
        }
    }
}

extension NewMarkerViewController : CameraDelegate {
    
    func saveImage(didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        
        if let error = error {
            NSLog("%@ \(error.localizedDescription)", "Error on saving image to device. Check permissions")
        } else {
            let alert = Alert(controller: self)
            alert.showOkOption("Sucess", message: "image saved to device") {
            //
            }
        }
    }
}

extension NewMarkerViewController : UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 1: return false
        case 2: return true
        case 3: return true
        case 4: return true
        default: break
        }
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        switch textField.tag {
        case 1 : NSLog("%@category", "tag \(textField.tag) "); break
        case 2 : NSLog("%@name", "tag \(textField.tag) "); break
        case 3 : NSLog("%@site", "tag \(textField.tag) "); break
        case 4 : NSLog("%@telephone", "tag \(textField.tag) "); break
        default: break
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField.tag {
        case 1 : break
        case 2 : break
        case 3 : break
        case 4 : return string.rangeOfCharacter(from: CharacterSet.letters) == nil
        default: break
        }
        
        return true
    }
    
}

extension NewMarkerViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch component {
        case 1:
            ddd = pickerData[component][row]
            break
        case 0 :
            ddi = pickerData[component][row]
            break
        default:
            break
        }
        NSLog("%@ DDD \(ddd)", "DDI \(ddi)")
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont.textMediumFont
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = pickerData[component][row]
        
        return pickerLabel!
    }
}

extension NewMarkerViewController : ViewMarkerFormDelegate {
    
    func cancelPhotoSelect(_ sender: Any) {
        customView.dismissMediaOptions()
    }
    func showTableOptions(_ sender: Any) {
        customView.showTable()
    }
    
    func addNewDiscipline(_ sender: Any) {
        checkLayoutStatus()
        let controller = NewButtonViewController()
        controller.reloadTableDelegate = self
        controller.placemark = self.placemark
        goTo(controller: controller)
    }
    func checkLayoutStatus(){
        
        if customView.listButtonTableView.alpha == 1 {
            customView.hideTable()
        }
        if customView.buttonSelectPhotoFromCamera.alpha == 1 {
            customView.dismissMediaOptions()
        }
        customView.endEditing(true)
        
    }
    func selectMediaOrigin(_ option: MenuOptions) {
        
        let media = UIImagePickerController()
        media.delegate = imagePicker
        
        switch option {
        case .camera:
            print("camera")
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                media.sourceType = .camera
            }
            break
        case .library :
            print("library")
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                media.sourceType = .photoLibrary
            }
            break
        case .savedPhotosAlbum :
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                media.sourceType = .savedPhotosAlbum
            }
            break
        }
        self.present(media, animated: true, completion: nil)
    }
    
    func backToPreviousController() {
        
        let alert = Alert(controller: self)
        alert.showOkWithCancelOption("Alert", message: "Are you sure to cancel this marker?") {option in
            if option == .confirm {
                DispatchQueue.main.async {
                    if let navigation = self.navigationController {
                        navigation.popViewController(animated: true)
                    }
                }
            }
        }
    }
    
    func savePin(_ sender : Any) {
        //
        if Validation.isTextFieldsEmpty(textFields: customView.textFields){
            let name = customView.textFieldPlaceName.text ?? ""
            
            let formatedName = name.condenseWhiteSpace()
            
            if Validation.isValidPinName(formatedName){
                
            } else {
                let alert = Alert(controller: self)
                alert.showOkOption("Atention", message: "This name has been taken") {
                }
                return
            }
            
            var siteUrl = customView.textFieldSite.text?.lowercased() ?? ""
            
            if !siteUrl.hasPrefix("http://"){
                siteUrl = "http://\(siteUrl)"
            }
            
            if Validation.isValidUrl(siteUrl){
                
            } else {
                let alert = Alert(controller: self)
                alert.showOkOption("Atention", message: "Please add a valid site") {
                }
                return
            }
            let telephone = "\(ddi)\(ddd)\(customView.textFieldTelephone.text ?? "")"
            
            if Validation.isValidTelephone(telephone) {
                
            } else {
                let alert = Alert(controller: self)
                alert.showOkOption("Atention", message: "Please add a valid telephone") {
                }
                return
            }
            
            let category = self.discipline ?? ""
            let placeMark = self.placemark!
            guard let image:UIImage = customView.imageViewPlace.image else {
                let alert = Alert(controller: self)
                alert.showOkOption("Image not selected", message: "You must select an image to continue") {
                    return
                }
                return}
            let dataImage = image.pngData() as NSData?
            
            NSLog("%@ category \(category) site \(siteUrl) telephone \(telephone)", "trimmed name \(formatedName)")
            
            let pin = Pin(name: formatedName, site: siteUrl, telephone: telephone, discipline: category, coordinate: placeMark.location!.coordinate, dataImage)
            
            delegate?.reloadPins()
            PinDAO().salvePin(pin)
            goTo(controller: MainViewController())
        } else {
            let alert = Alert(controller: self)
            alert.showOkOption("Atention", message: "Please fill in all fields") {
             NSLog("aaaAAâ5å")
            }
        }
        
    }
}
// MARK: - Camera
extension NewMarkerViewController : ImagePickerDelegate {
    
    fileprivate func setupImagePicker() {
        imagePicker.delegate = self
    }
    fileprivate func saveImageToDevice(){
        guard let image = customView.imageViewPlace.image else {print("no guard"); return}
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil) 
    }
    func changeImage(_ image: UIImage) {
        customView.imageViewPlace.image = image
        let camera = Camera()
        camera.delegate = self
        camera.saveImage(image)
        //camera.saveImageToDevice(image)
    }
}

extension NewMarkerViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return disciplineOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellId, for: indexPath) as! ListButtonTableViewCell
        if buttonOptions != nil {
            let title = buttonOptions![indexPath.row].title
            let imageName = buttonOptions![indexPath.row].imageName
            cell.setupCell(title, imageName: imageName)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height * 0.05
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        if let cell = tableView.cellForRow(at: indexPath) as? ListButtonTableViewCell {
            NSLog("%@\(indexPath.row)", "did select indexPath at row: ")
            customView.textFieldCategory.text = cell.imageName.text
            self.discipline = cell.iconImage.image?.accessibilityIdentifier
            customView.listButtonTableView.reloadData()
            
        } else{
            Alert(controller: self).showOkOption(completion: {})
        }
    }
}

extension NewMarkerViewController : ReloadTableViewDelegate {
    
    func reloadTable() {
        
        self.buttonOptions = []
        self.buttonOptions = ButtonDAO().retrieveButtons()
        
        if buttonOptions != nil {
            disciplineOptions = []
            for i in 0...buttonOptions!.count - 1 {
                disciplineOptions.append(buttonOptions![i].imageName!)
            }
        }
        
        customView.listButtonTableView.reloadData()
        delegate?.reloadButtons()
    }
}
