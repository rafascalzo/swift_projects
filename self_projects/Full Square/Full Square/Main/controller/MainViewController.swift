//
//  MainViewController.swift
//  Full Square

//  Created by macbook-estagio on 30/07/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import AudioToolbox

class MainViewController: UIViewController {
    
    //MARK: - Attributes
    typealias CustomView = MainView
    
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
    
    var actualButtonFrame : CGRect!
    var actualButtonPoint : CGPoint!
    var fileViewOrigin : CGPoint!
    let imagePicker = ImagePicker()
    var pins : [Pin] = []
    var fetchedPins : [Pin] = []
    let debouncer = Debouncer(timeInterval: 1)
    let locationManager = CLLocationManager()
    let regionInMeters:Double = 1000
    var placemark:CLPlacemark?
    var previousLocation : CLLocation?
    var buttons : Array<Button>?
    var pinMarkers : Array<PinMarker>?
    var placeMarks : [CLPlacemark] = []
    var isEditingMap : Bool = false
    var scrollview = UIScrollView()
    
    // MARK: - View Lifecycle
    override func loadView() {
        super.loadView()
        let customView = CustomView()
        customView.delegate = self
        view = customView
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadButtons()
        setupMapConfiguration()
        setupNavigation()
        setupCustomSearchTextViewDelegate()
        initialLocation()
        reloadMapItens(with: nil)
       
    }
    
    @objc func handleTap(){
        (0...10).forEach { (_) in
            generateAnimationViews()
        }
    }
    fileprivate func generateAnimationViews(){
        let images = ["white-thumbs-up","white-heart"]
        let imageName :String = images.randomElement()!
        let image = UIImage(named: imageName)
        image?.accessibilityIdentifier = imageName
        
        let dimension = 20 + drand48() + 10
        let imageView = UIButton()
        
        imageView.setImage(image, for: .normal)
        imageView.imageEdgeInsets = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        
        imageView.frame = CGRect(x: 0, y: 0, width: dimension, height: dimension)
        imageView.layer.cornerRadius = 15
        imageView.backgroundColor = image?.accessibilityIdentifier == "white-heart" ? .redColor : .blueColor
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = customPath().cgPath
        animation.duration = 2 + drand48() * 3
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        imageView.layer.add(animation, forKey: nil)
        
        view.addSubview(imageView)
    }
    
    fileprivate func loadButtons(){
        
        buttons = []
        buttons = ButtonDAO().retrieveButtons()
        
        if buttons?.count == 0 {
            var tag:Int = 0
            let initialImages = ["hostpital-building","home","ambulance","gamepad-console","shopping-cart"]
            let initialNames = ["Hospital","Home","Ambulance","Game","Market"]
//            let initialImages = ["hostpital-building","home","ambulance","gamepad-console","shopping-cart","film","ticket","beaker","medical-kit","credit-card","anchor","umbrella"]
//            let initialNames = ["Hospital","Home","Ambulance","Game","Market","film","ticket","beaker","medical-kit","credit-card","anchor","umbrella"]
            
            initialImages.forEach { (imageName) in
                let uuid = NSUUID().uuidString
                let id = UUID(uuidString: uuid)
                let button = ButtonModel(id: id!, title: initialNames[tag], imageName: imageName)
                ButtonDAO().saveButton(button)
                tag+=1
            }
            buttons = ButtonDAO().retrieveButtons()
        }
        customView.loadButtons(buttons!)
        customView.layoutIfNeeded()
    }
    
    fileprivate func setupNavigation() {
        if let navigation = navigationController {
            navigation.isNavigationBarHidden = true
        }
    }
    @objc public func showDetails(_ sender : Any){
        
        if sender is UIButton {
            
            let button = sender as! UIButton
            let allpins = PinDAO().retrievePins()
            
            for selectedPin in allpins {
                if selectedPin.name == button.accessibilityIdentifier {
                    let alert = PinMenuOptions().showOptions { (option) in
                        switch option {
                        case .call :
                            Telephone().makeACallTo(selectedPin)
                            break
                        case .site :
                            Safari().open(url: selectedPin.site!, from: self)
                            break
                        }
                    }
                    
                    if let popoverController = alert.popoverPresentationController{
                        NSLog("%@ dhsaiufhadisuf", "fadsfgsdf ")
                        popoverController.barButtonItem = UIBarButtonItem(customView: button)
                        //popoverController.barButtonItem = button as? UIBarButtonItem
                    }
                    present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    // - Map methods
    func initialLocation(){
        previousLocation = getCenterLocation(for: customView.map)
    }
    fileprivate func setupMapConfiguration() {
        if #available(iOS 11.0, *) {
            customView.map.register(PinMarkerView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
            
        } else {
            let alert = Alert(controller: self)
            alert.showOkOption("Atention", message: "This resource is supported only in iOS 11.0 or later.") {
                print("completion")
            }
        }
        customView.map.delegate = self
        checkLocationServices()
        initialLocation()
    }
    fileprivate func setupLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    fileprivate func startTrackingUserLocation() {
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: customView.map)
        print(previousLocation!)
    }
    fileprivate func centerViewOnUserLocation(){
        
        if let location = locationManager.location?.coordinate{
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            self.customView.map.setRegion(region, animated: true)
        }
    }
    
    fileprivate func checkLocationServices(){
        
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
            setupCustomSearchTextViewDelegate()
        } else {
            let alert = Alert(controller: self)
            alert.showOkOption("Atention", message: "Location services are not enabled. This allow us to use your location to provide features like tracking your preferred spots based on your current location") {
            }
        }
    }
    fileprivate func checkLocationAuthorization(){
        
        switch CLLocationManager.authorizationStatus() {
            
        case .authorizedWhenInUse:
            centerViewOnUserLocation()
            break
        case .denied :
            let alert = Alert(controller: self)
            alert.showOkOption("Atention", message: "Location permissions denied. Please check manually if location services are enabled.") {
            }
            break
        case .notDetermined :
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted :
            let alert = Alert(controller: self)
            alert.showOkOption("Atention", message: "Location permissions denied by a restricted location services") {
            }
            break
        case .authorizedAlways :
            break
        @unknown default:
            break
        }
    }
    
    func startMapEdit(){
        isEditingMap = !isEditingMap
        customView.addEditingComponents()
    }
    
    func endMapEdit(completion : (() -> Void)?){
        isEditingMap = !isEditingMap
        customView.removeEditingComponents()
        completion?()
    }
    
    func searchBarAction(){
        let text = customView.searchBarTextField.text!
        var found = false
        if pins.count > 0 {
            for i in 0...pins.count - 1 {
                if text == pins[i].title {
                    found = true
                    let pin = pins[i]
                    customView.map.showAnnotations([pin], animated: true)
                }
            }
        }
        customView.endEditing(true)
        if !found {
            let alert = Alert(controller: self)
            alert.showOkOption("404", message: "Location not found", completion: nil)
        }
    }
    func addPanGesture(view : UIView){
        fileViewOrigin = view.frame.origin
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(pan)
    }

}
extension MainViewController : ReloadMainView {
    
    func reloadButtons() {
        loadButtons()
    }
    
    func reloadMapItens(with pins : Array<Pin>?){
        
        if pins == nil {
            let annotationsToRemove = customView.map.annotations.filter { $0 !== customView.map.userLocation }
            customView.map.removeAnnotations( annotationsToRemove )
            
            let pinList = PinDAO().retrievePins()
            if pinList.count > 0 {
                
                let annotationsToRemove = customView.map.annotations.filter { $0 !== customView.map.userLocation }
                customView.map.removeAnnotations( annotationsToRemove )
                
                for i in 0...pinList.count - 1 {
                    
                    guard let title = pinList[i].name else {return}
                    guard let site = pinList[i].site else {return}
                    guard let telephone = pinList[i].telephone else {return}
                    guard let discipline = pinList[i].category else {return}
                    let latitude:Double =  pinList[i].latitude
                    let longitude:Double = pinList[i].longitude
                    let coordinates: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
                    guard let data = pinList[i].image else {return}
                    let pin = Pin(name: title, site: site, telephone: telephone, discipline: discipline, coordinate: coordinates, NSData(data: data))
                    self.pins.append(pin)
                    self.customView.map.addAnnotation(pin)
                }
                view.layoutIfNeeded()
            }
        } else {
            let annotationsToRemove = customView.map.annotations.filter { $0 !== customView.map.userLocation }
            customView.map.removeAnnotations( annotationsToRemove )
            self.pins = []
            for i in 0...pins!.count - 1 {
                self.pins.append(pins![i])
            }
        }
    }
    
    func reloadPins(){
        self.reloadMapItens(with: nil)
    }
}

extension MainViewController : UITextFieldDelegate {
    
    func setupCustomSearchTextViewDelegate(){
        customView.searchBarTextField.delegate = self
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchBarAction()
        customView.endEditing(true)
        textField.endEditing(true)
        return true
    }
   
}
extension MainViewController : MainViewDelegate {
    func textFieldDidChange(_ textField: UITextField) {
        print(textField)
    }
    
    func handleTapGesture(_ sender: Any) {
        
        for button in customView.footerButtons{
            if button.gestureRecognizers?.last is UIPanGestureRecognizer {
                customView.sendSubviewToBack(button)
                removeGesturesOf(button)
                button.addLongPressGestureRecognizer {
                    if let recognizer = button.gestureRecognizers?.first! as? UILongPressGestureRecognizer{
                        self.handleLongPressGesture(recognizer)
                    }
                }
                customView.hideTrash()
            }
        }
        customView.endEditing(true)
    }
    func cancelEditing(_ sender: Any) {
        endMapEdit( completion: nil)
        customView.removeEditingComponents()
        reloadMapItens(with: nil)
    }
    func configurePin(_ sender : Any) {
        
        endMapEdit(completion: {
            
            self.getPlacemark(completion: {
                let controller = NewMarkerViewController()
                controller.buttonOptions = self.buttons
                controller.placemark = self.placemark
                controller.delegate = self
                if let navigation = self.navigationController {
                    navigation.pushViewController(controller, animated: true)
                }
            })
        })
    }
    
    func footerBarButtonAction(_ sender : Any) {
        let button = sender as! UIButton
        var anotationsToShow : [MKAnnotation] = []
        if pins.count > 0 {
            for i in 0...pins.count - 1 {
                if pins[i].category == button.accessibilityIdentifier {
                    anotationsToShow.append(pins[i])
                }
            }
            customView.map.showAnnotations(anotationsToShow, animated: true)
        }
    }
    
    fileprivate func animateToRight(_ position: Int) {
        customView.animateToRight(position)
    }
    fileprivate func tryAnimateToRight(_ position: Int) {
        customView.tryAnimateToRight(position)
    }
    fileprivate func animateToLeft(_ position: Int) {
        customView.animateToLeft(position)
    }
    fileprivate func tryAnimateToLeft(_ position: Int) {
        customView.tryAnimateToLeft(position)
    }
    
    func handleSwipes(_ swipes : [UISwipeGestureRecognizer]){
        
        var recognizer = UISwipeGestureRecognizer()
        
        for gesture in swipes {
            if gesture.state == .recognized {
                recognizer = gesture
            }
        }
        
        let location = CGPoint.thirdButtonPoint
        let hitTest = self.customView.footerView.hitTest(location, with: nil)
        
        if recognizer.direction == .left {
            NSLog("%@\(recognizer.direction)", "Direction: ")
            if hitTest is UIButton {
                let position = hitTest!.tag - 2
                if hitTest!.tag < (customView.footerButtons.count - 3) {
                    animateToLeft(position)
                } else {
                    tryAnimateToLeft(position)
                }
            }
        }
        if recognizer.direction == .right {
            NSLog("%@\(recognizer.direction)", "Direction: ")
            if hitTest is UIButton {
                let position = hitTest!.tag - 2
                if hitTest!.tag > 2 {
                    animateToRight(position)
                } else {
                    tryAnimateToRight(position)
                }
            }
        }
    }
    
    @objc func handleLongPressGesture(_ recognizer : UILongPressGestureRecognizer){
        
        if recognizer.state == .began {
            
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            let buttonMenuOptions = ButtonMenuOptions().configureButtonOptions { (option) in
                
                switch option {
                case .delete :
                    if self.buttons!.count <= 5 {
                        let alert = Alert(controller: self)
                        alert.showOkOption("Atention", message: "You need to keep at least 5 categories") {
                        }
                    } else {
                        self.customView.showTrash()
                        let button = recognizer.view as! UIButton
                        self.customView.bringSubviewToFront(button)
                        self.addPanGesture(view: button)
                        self.customView.bringSubviewToFront(button)
                        self.actualButtonFrame = button.frame
                        // atualizar lista de botoes
                    }
                    break
                case .edit :
                    break
                }
            }
            if #available(iOS   8.0, *){
                 let button = recognizer.view as! UIButton
                if let popoverController = buttonMenuOptions.popoverPresentationController{
                    NSLog("%@ mode", "popoverController")
                    popoverController.barButtonItem = UIBarButtonItem(customView: button)
                }
            }
            self.present(buttonMenuOptions, animated: true, completion: nil)
        }
    }
    func returnViewToOrigin(view : UIView) {
        UIView.animate(withDuration: 0.5) {
            view.frame.origin = self.fileViewOrigin
            view.layer.transform = CATransform3DIdentity
        }
    }
    fileprivate func removeGesturesOf(_ button: UIButton) {
        for recognizer in button.gestureRecognizers! {
            if recognizer != UILongPressGestureRecognizer() {
                button.removeGestureRecognizer(recognizer)
            }
        }
    }
    
    fileprivate func deleteButton(_ button: UIButton) {
        // remove from core data
        ButtonDAO().deleteButton(self.buttons![button.tag])
        
        // remove from controller
        buttons?.remove(at: button.tag)
        
        //remove from view
        customView.footerButtons.remove(at: button.tag)
        
        buttons = ButtonDAO().retrieveButtons()
        self.loadButtons()
    }
    
    fileprivate func remove(_ button: UIButton, at position: Int) {
//        self.deleteButton(button)
//        UIView.animate(withDuration: 0.75, animations: {
//          self.customView.layoutIfNeeded()
//        })
        switch position {
        case  1 :
            customView.removeFirst(button, completion: {
                self.deleteButton(button)
            })
            break
        case 2 :
            customView.removeSecond(button, completion : {
                self.deleteButton(button)
            })
            break
        case 3 :
            customView.removeThird(button, completion: {
                self.deleteButton(button)
            })
            break
        case 4 :
            customView.removeFourth(button, completion: {
                self.deleteButton(button)
            })
            break
        case 5 :
            customView.removeFifth(button, completion: {
                self.deleteButton(button)
            })
            break
        default :
            break
        }
    }
    
    @objc func handlePanGesture(_ sender : UIPanGestureRecognizer){
        
        let fileView = sender.view!
        let translation = sender.translation(in: self.customView)
        let button = sender.view as! UIButton
        
        switch sender.state {
        case .began , .changed:
            fileView.center = CGPoint(x: fileView.center.x + translation.x , y: fileView.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: self.customView)
            break
        case .ended :
           
            let correctFrame : CGRect = CGRect(x: customView.imageViewTrash.frame.minX, y: -customView.imageViewTrash.frame.minY, width: customView.imageViewTrash.frame.width, height: customView.frame.height)
            
            if button.frame.contains(CGPoint(x: correctFrame.midX, y: correctFrame.midY)){
                
                let alert = Alert(controller: self)
                alert.showOkWithCancelOption("Atention", message: "Are you sure to delete this category? All markers of this category will be removed") {option in
                    
                    switch option {
                        
                    case .confirm :
                        let points = [CGPoint.firstButtonPoint, .secondButtonPoint, .thirdButtonPoint, .fourthButtonPoint , .fifthButtonPoint]
                        var i = 1
                        for point in points {
                            if self.actualButtonFrame.contains(point) {
                                NSLog("%@ \(i)", "point ")
                                break
                            }
                            i+=1
                        }
                        
                        NSLog("%@ button frame: \(button.frame)", "trash frame: \(self.customView.imageViewTrash.frame), correct frame: \(correctFrame)")
                        self.remove(button, at: i)
                        
                        self.pinMarkers = PinDAO().retrievePins()
                        if self.pinMarkers!.count > 0 {
                            for i in 0...self.pinMarkers!.count - 1 {
                                if self.pinMarkers![i].category == button.accessibilityIdentifier {
                                    NSLog("%@\(self.pinMarkers![i].name)...", "Deleting ")
                                    PinDAO().deletePin(self.pinMarkers![i])
                                }
                            }
                        }
                        self.reloadMapItens(with: nil)
                        break
                    case .cancel :
                        NSLog("%@ button frame: \(button.frame)", "trash frame: \(self.customView.imageViewTrash.frame), correct frame: \(correctFrame)")
                        self.returnViewToOrigin(view: button)
                        self.customView.sendSubviewToBack(button)
                        self.removeGesturesOf(button)
                        button.addLongPressGestureRecognizer {
                            if let recognizer = button.gestureRecognizers?.first! as? UILongPressGestureRecognizer{
                                self.handleLongPressGesture(recognizer)
                            }
                        }
                        break
                    }
                }
            }else{
                NSLog("%@ button frame: \(button.frame)", "trash frame: \(customView.imageViewTrash.frame), correct frame: \(correctFrame)")
                returnViewToOrigin(view: button)
                customView.sendSubviewToBack(button)
                removeGesturesOf(button)
                button.addLongPressGestureRecognizer {
                    if let recognizer = button.gestureRecognizers?.first! as? UILongPressGestureRecognizer{
                        self.handleLongPressGesture(recognizer)
                    }
                }
            }
            customView.hideTrash()
            break
        default:
            break
        }
    }
}

extension MainViewController : MKMapViewDelegate {
    
    func getCenterLocation(for mapview: MKMapView) -> CLLocation {
        let latitude = mapview.centerCoordinate.latitude
        let longitude = mapview.centerCoordinate.longitude
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    func getPlacemark(completion: @escaping() -> Void){
        let center = getCenterLocation(for: customView.map)
        let geoCoder = CLGeocoder()
        
        geoCoder.reverseGeocodeLocation(center) { (placemarks, error) in
            if let _ = error {
                let alert = Alert(controller: self)
                alert.showOkOption("Error", message: "Try again later", completion: nil)
                return
            }
            guard let placemark = placemarks?.first else {
                let alert = Alert(controller: self)
                alert.showOkOption("404", message: "Location not found", completion: nil)
                return
            }
            self.placemark = placemark
            
            print("self.placemark\(String(describing: self.placemark))")
            completion()
        }
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        if isEditingMap {
            let center = getCenterLocation(for: mapView)
            let geoCoder = CLGeocoder()
            guard let previousLocation = self.previousLocation else {return}
            guard center.distance(from: previousLocation) > 5 else {return}
            self.previousLocation = center
            
            geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
                guard self != nil else {return}
                if let _ = error {
                    let alert = Alert(controller: self!)
                    alert.showOkOption("Atention", message: "Error. Try again later", completion: nil)
                    return
                }
                guard let placemark = placemarks?.first else {
                    let alert = Alert(controller: self!)
                    alert.showOkOption("Atention", message: "Location not found", completion: nil)
                    return
                }
                let streetNumber = placemark.subThoroughfare ?? "terra indigena"
                let streetName = placemark.thoroughfare ?? "número indígena"
                
                NSLog("%@\(streetName) \(streetNumber)", "YOU ARE IN ")
            }
        }
    }
}

extension MainViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        customView.map.setRegion(region, animated: true   )
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}

extension MainViewController : UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return true
    }
}
