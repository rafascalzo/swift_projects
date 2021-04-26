//
//  MainView.swift
//  Full Square
//
//  Created by macbook-estagio on 30/07/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//
import MapKit
import UIKit
import SnapKit

class MainView: UIView {
    
    // MARK: - Constants
    struct Constants {
        static let device = UIDevice.current.userInterfaceIdiom
        static let screenSize:CGSize = UIScreen.main.bounds.size
        static let layoutGuide = UILayoutGuide()
        
        static let customSearchBarViewHeight: CGFloat = Constants.device == .phone ? 39 : 50
        static let imageViewPinWidth = Constants.device == .phone ? 23 : 46
    }
    
    // MARK: - Attributtes
    var delegate : MainViewDelegate?
    var footerButtons : [UIButton] = []
    
    var map : MKMapView = {
        var map = MKMapView()
        map.showsUserLocation = true
        //map.mapType = .hybrid
        return map
    }()
    var customSearchBarView : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .darkGrayColor
        view.addShadow(UIColor.shadowDarkColor, shadowOptions: .bottom)
        return view
    }()
    var searchBarTextField : UITextField = {
        let textField = UITextField()
        textField.clearsOnBeginEditing = true
        textField.placeholder = "Search location"
        textField.moveCursor(7)
        textField.textColor = .black
        textField.backgroundColor = .whiteColor
        textField.layer.cornerRadius = 12
        // textView.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()
    let searchBarIcon : UIImageView = {
        let imageView = UIImageView()
        let image = UIImage.resize(image: UIImage(named: "magnifying-glass")!, targetSize: CGSize(width: Constants.customSearchBarViewHeight, height: Constants.customSearchBarViewHeight))
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    let buttonSelectNewMarker : UIButton = {
        let button = UIButton()
        button.addShadow(.shadowDarkColor, shadowOptions: .bottom)
        button.addCenterImage(named: "map-marker", withMargin: 10, backgroundColor: .clear, size: button.intrinsicContentSize)
        button.addTarget(self, action: #selector(startMapEdit(_:)), for: .touchUpInside)
        return button
    }()
    var footerView : UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.backgroundColor = .clear
        return view
    }()
    var imageViewTrash : UIImageView = {
        let imageView = UIImageView()
        imageView.alpha = 0
        imageView.image = UIImage(named: "trash")
        return imageView
    }()
    var buttonSave : UIButton = {
        let button = UIButton()
        button.alpha = 0
        button.addShadow(.shadowDarkColor, shadowOptions: .bottom)
        button.makeCircular(with: CGFloat.defaultCircularButtonSize)
        button.addCenterImage(named: "save-file-option", withMargin: nil, backgroundColor: .grayColor, size: button.intrinsicContentSize)
        button.addTarget(self, action: #selector(configurePin(_:)), for: .touchUpInside)
        return button
    }()
    let buttonCancelEditing : UIButton = {
        let button = UIButton()
        button.alpha = 0
        button.addCenterImage(named: "arrow-left", withMargin: 7, backgroundColor: .grayColor, size: button.intrinsicContentSize)
        button.makeCircular(with: CGFloat.defaultCircularButtonSize)
        button.addShadow(.shadowDarkColor, shadowOptions: .bottom)
        button.addTarget(self, action: #selector(cancelEditing(_:)), for: .touchUpInside)
        return button
    }()
    var imageViewPin : UIImageView = {
        let imageView = UIImageView()
        imageView.alpha = 0
        imageView.image = UIImage(named: "center-aim")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var fileViewOrigin : CGPoint!
    
    // MARK: - View Lifecycle
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setupView()
        addSearchBarIconRecognizer()
        footerView.addSwipeGestureRecognizer {
            guard let leftSwipe = self.footerView.gestureRecognizers?.first as? UISwipeGestureRecognizer else {return}
            guard let rightSwipe = self.footerView.gestureRecognizers?.last as? UISwipeGestureRecognizer else {return}
            let swipes : [UISwipeGestureRecognizer] = [leftSwipe,rightSwipe]
            self.delegate?.handleSwipes(swipes)
        }
        self.addTapGestureRecognizer {
            self.delegate?.handleTapGesture(self)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Methods
    fileprivate func setupView() {
        
        addSubview(map)
        map.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        addSubview(customSearchBarView)
        customSearchBarView.snp.makeConstraints { (make) in
            if #available(iOS 11, *) {
                make.top.equalTo(safeAreaLayoutGuide.snp.top)
            } else {
                make.top.equalToSuperview().offset(CGFloat.paddingLarge)
            }
            make.leadingMargin.equalTo(CGFloat.paddingSmall)
            make.trailingMargin.equalTo(-CGFloat.paddingSmall)
            make.height.equalTo(Constants.customSearchBarViewHeight)
        }
        customSearchBarView.addSubview(searchBarIcon)
        searchBarIcon.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(6)
            make.leading.equalToSuperview().offset(6)
            make.bottom.equalToSuperview().inset(6)
            make.width.equalTo(35)
        }
        customSearchBarView.addSubview(searchBarTextField)
        searchBarTextField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(6)
            make.bottom.equalToSuperview().inset(6)
            make.leading.equalTo(searchBarIcon.snp.trailing).offset(6)
            make.trailing.equalToSuperview().offset(-6)
        }
        addSubview(footerView)
        footerView.snp.makeConstraints { (make) in
            NSLog("%@\(UIDevice.current.localizedModel)", "Device ")
            if #available(iOS 11, *) {
                make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            } else {
                make.bottomMargin.equalTo(-CGFloat.paddingSmall)
            }
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(CGFloat.footerHeight)
        }
        footerView.addBlur()
        addSubview(buttonSelectNewMarker)
        buttonSelectNewMarker.snp.makeConstraints { (make) in
            make.top.equalTo(customSearchBarView.snp.bottom).offset(CGFloat.paddingSmall)
            make.trailingMargin.equalTo(customSearchBarView).offset(CGFloat.paddingSmall / 2)
            make.height.equalTo(CGFloat.defaultCircularButtonSize)
            make.width.equalTo(CGFloat.defaultCircularButtonSize)
        }
        addSubview(imageViewTrash)
        imageViewTrash.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-CGFloat.paddingLarge)
            make.height.equalTo(CGFloat.defaultCircularButtonSize)
            make.width.equalTo(CGFloat.defaultCircularButtonSize)
            make.topMargin.equalTo(500)
        }
    }
    func addEditingComponents() -> Void {
        
        addSubview(buttonCancelEditing)
        buttonCancelEditing.snp.makeConstraints { (make) in
            make.topMargin.equalTo(CGFloat.paddingLarge)
            make.leadingMargin.equalTo(CGFloat.paddingSmall)
            make.width.equalTo(CGFloat.defaultCircularButtonSize)
            make.height.equalTo(CGFloat.defaultCircularButtonSize)
        }
        addSubview(imageViewPin)
        imageViewPin.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(Constants.imageViewPinWidth)
            make.height.equalTo(Constants.imageViewPinWidth)
        }
        addSubview(buttonSave)
        buttonSave.snp.makeConstraints { (make) in
            make.centerY.equalTo(footerView.snp.centerY)
            make.centerX.equalTo(footerView.snp.centerX)
            make.leading.equalToSuperview().offset(CGFloat.paddingLarge)
            make.trailing.equalToSuperview().inset(CGFloat.paddingLarge)
            make.height.equalTo(CGFloat.defaultCircularButtonSize)
        }
        showEditingComponents()
    }
    
    func showEditingComponents() {
        bringSubviewToFront(map)
        bringSubviewToFront(buttonSave)
        bringSubviewToFront(buttonCancelEditing)
        bringSubviewToFront(imageViewPin)
        layoutIfNeeded()
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
            self.buttonSave.alpha = 1
            self.buttonCancelEditing.alpha = 1
            self.imageViewPin.alpha = 1
        })
    }
    func removeEditingComponents(){
       
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
            
            self.imageViewPin.alpha = 0
            self.buttonSave.alpha = 0
            self.buttonCancelEditing.alpha = 0
        }) { (_) in
            
            self.buttonSave.removeFromSuperview()
            self.buttonCancelEditing.removeFromSuperview()
            self.imageViewPin.removeFromSuperview()
            
            self.bringSubviewToFront(self.footerView)
            self.bringSubviewToFront(self.customSearchBarView)
            self.bringSubviewToFront(self.buttonSelectNewMarker)
        }
    }
    
    fileprivate func addConstraints(to button: UIButton, on location:CGPoint) {
        
        button.snp.makeConstraints { (make) in
            make.center.equalTo(location)
            make.height.equalTo(CGFloat.iconHeight)
            make.width.equalTo(CGFloat.iconWidth)
        }
    }
    
    func deleteButton(position : Int){
        footerButtons[position].removeFromSuperview()
        footerButtons.remove(at: position)
        
        for i in 0...footerButtons.count - 1{
            footerButtons[i].tag = i
        }
        layoutIfNeeded()
    }
    func loadButtons(_ buttons : Array<Button>){
        
        footerButtons = []
        
        for view in footerView.subviews {
            view.removeFromSuperview()
        }
        
        for i in 0...buttons.count - 1 {
            let margin : CGFloat = UIScreen.main.bounds.width * 0.001
            let imageName = buttons[i].imageName ?? ""
            let button = UIButton()
            button.setupTaggedImageButton(named: imageName, tag: i, backGroundColor: .grayColor, withRadius: CGFloat.iconWidth / 2, margin: margin, size: button.intrinsicContentSize)
            //button.setBackgroundImage(UIImage(named: "background-white"), for: .normal)
            // button.layer.masksToBounds = true
            button.accessibilityIdentifier = imageName
            button.addTarget(self, action: #selector(footerBarButtonAction(_:)), for: .touchUpInside)
            button.addShadow(.shadowDarkColor, shadowOptions: .bottom)
            button.addLongPressGestureRecognizer {
                if let longpress = button.gestureRecognizers!.first as? UILongPressGestureRecognizer{
                    self.delegate?.handleLongPressGesture(longpress)
                }
            }
            footerButtons.append(button)
            footerView.addSubview(button)
            if i < 5 {
                switch i {
                case 0 :
                    addConstraints(to: button, on: CGPoint.firstButtonPoint)
                    break
                case 1 :
                    addConstraints(to: button, on: CGPoint.secondButtonPoint)
                    break
                case 2 :
                    addConstraints(to: button, on: CGPoint.thirdButtonPoint)
                    break
                case 3 :
                    addConstraints(to: button, on: CGPoint.fourthButtonPoint)
                    break
                case 4 :
                    addConstraints(to: button, on: CGPoint.fifthButtonPoint)
                    break
                default:
                    break
                }
            } else {
                addConstraints(to: button, on: CGPoint.rightHiddenButtonPoint)
            }
        }
    }
    
    @objc func cancelEditing(_ sender : Any){
        delegate?.cancelEditing(sender)
    }
    @objc func configurePin(_ sender : Any){
        delegate?.configurePin(sender)
    }
    @objc func startMapEdit(_ sender : Any){
        delegate?.startMapEdit()
    }
    @objc func searchBarAction(_ sender : Any){
        delegate?.searchBarAction()
    }
    @objc func footerBarButtonAction(_ sender : Any){
        delegate?.footerBarButtonAction(sender)
    }
    
    func addSearchBarIconRecognizer(){
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(searchBarAction(_:)))
        searchBarIcon.addGestureRecognizer(recognizer)
    }
    
    // Animation Functions
    func showTrash() -> Void {
        NSLog("%@\(imageViewTrash.bounds.origin)", "Image origin ")
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: {
            self.imageViewTrash.alpha = 1
        })
    }
    func hideTrash() -> Void {
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: {
            self.imageViewTrash.alpha = 0
        })
    }
    func animateToRight(_ position: Int) {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
            self.footerButtons[position - 1].center = .firstButtonPoint
            self.footerButtons[position].center = .secondButtonPoint
            self.footerButtons[position + 1].center = .thirdButtonPoint
            self.footerButtons[position + 2].center = .fourthButtonPoint
            self.footerButtons[position + 3].center = .fifthButtonPoint
            self.footerButtons[position + 4].center = .rightHiddenButtonPoint
        })
    }
    func tryAnimateToRight(_ position: Int) {
        
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.footerButtons[position].transform = CGAffineTransform(translationX: 30, y: 0)
            self.footerButtons[position + 1].transform = CGAffineTransform(translationX: 30, y: 0)
            self.footerButtons[position + 2].transform = CGAffineTransform(translationX: 30, y: 0)
            self.footerButtons[position + 3].transform = CGAffineTransform(translationX: 30, y: 0)
            self.footerButtons[position + 4].transform = CGAffineTransform(translationX: 30, y: 0)
            if self.footerButtons.count > 5 {
                self.footerButtons[position + 5].transform = CGAffineTransform(translationX: 30, y: 0)
            }
        }) { (_) in
            UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.footerButtons[position].transform = CGAffineTransform.identity
                self.footerButtons[position + 1].transform = CGAffineTransform.identity
                self.footerButtons[position + 2].transform = CGAffineTransform.identity
                self.footerButtons[position + 3].transform = CGAffineTransform.identity
                self.footerButtons[position + 4].transform = CGAffineTransform.identity
                if self.footerButtons.count > 5 {
                    self.footerButtons[position + 5].transform = CGAffineTransform.identity
                }
            })
        }
    }
    func animateToLeft(_ position: Int) {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
            self.footerButtons[position].center = .leftHiddenButtonPoint
            self.footerButtons[position + 1].center = .firstButtonPoint
            self.footerButtons[position + 2].center = .secondButtonPoint
            self.footerButtons[position + 3].center = .thirdButtonPoint
            self.footerButtons[position + 4].center = .fourthButtonPoint
            self.footerButtons[position + 5].center = .fifthButtonPoint
        })
    }
    func tryAnimateToLeft(_ position: Int) {
        
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            if self.footerButtons.count > 5 {
                self.footerButtons[position - 1].transform = CGAffineTransform(translationX: -30, y: 0)
            }
            self.footerButtons[position].transform = CGAffineTransform(translationX: -30, y: 0)
            self.footerButtons[position + 1].transform = CGAffineTransform(translationX: -30, y: 0)
            self.footerButtons[position + 2].transform = CGAffineTransform(translationX: -30, y: 0)
            self.footerButtons[position + 3].transform = CGAffineTransform(translationX: -30, y: 0)
            self.footerButtons[position + 4].transform = CGAffineTransform(translationX: -30, y: 0)
        }) { (_) in
            UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                if self.footerButtons.count > 5 {
                    self.footerButtons[position - 1].transform = CGAffineTransform.identity
                }
                self.footerButtons[position].transform = CGAffineTransform.identity
                self.footerButtons[position + 1].transform = CGAffineTransform.identity
                self.footerButtons[position + 2].transform = CGAffineTransform.identity
                self.footerButtons[position + 3].transform = CGAffineTransform.identity
                self.footerButtons[position + 4].transform = CGAffineTransform.identity
            })
        }
    }
    func removeFirst(_ button: UIButton, completion : @escaping () -> Void) {
        
        if button.tag > 0 {
            UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                button.alpha = 0
                self.footerButtons[button.tag - 1].center = CGPoint.firstButtonPoint
            }) { (_) in
                completion()
            }
            
        } else {
            UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.footerButtons[button.tag + 1].center = CGPoint.firstButtonPoint
                self.footerButtons[button.tag + 2].center = CGPoint.secondButtonPoint
                self.footerButtons[button.tag + 3].center = CGPoint.thirdButtonPoint
                self.footerButtons[button.tag + 4].center = CGPoint.fourthButtonPoint
                self.footerButtons[button.tag + 5].center = CGPoint.fifthButtonPoint
            }) { (_) in
                completion()
            }
        }
    }
    func removeSecond(_ button: UIButton, completion : @escaping () -> Void) {
        
        if button.tag > 1 {
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
                self.footerButtons[button.tag - 2].center = CGPoint.firstButtonPoint
                self.footerButtons[button.tag - 1].center = CGPoint.secondButtonPoint
            }) { (_) in
                completion()
            }
        } else {
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
                self.footerButtons[button.tag + 1].center = CGPoint.secondButtonPoint
                self.footerButtons[button.tag + 2].center = CGPoint.thirdButtonPoint
                self.footerButtons[button.tag + 3].center = CGPoint.fourthButtonPoint
                self.footerButtons[button.tag + 4].center = CGPoint.fifthButtonPoint
            }) { (_) in
                completion()
            }
        }
    }
    func removeThird(_ button: UIButton, completion : @escaping () -> Void) {
        if button.tag > 2 {
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
                self.footerButtons[button.tag - 1].center = CGPoint.thirdButtonPoint
                self.footerButtons[button.tag - 2].center = CGPoint.secondButtonPoint
                self.footerButtons[button.tag - 3].center = CGPoint.firstButtonPoint
            }) { (_) in
                completion()
            }
        } else {
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
                self.footerButtons[button.tag + 1].center = CGPoint.thirdButtonPoint
                self.footerButtons[button.tag + 2].center = CGPoint.fourthButtonPoint
                self.footerButtons[button.tag + 3].center = CGPoint.fifthButtonPoint
            }) { (_) in
                completion()
            }
        }
    }
    func removeFourth(_ button: UIButton, completion : @escaping () -> Void) {
        if button.tag > 3 {
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
                self.footerButtons[button.tag - 1].center = CGPoint.fourthButtonPoint
                self.footerButtons[button.tag - 2].center = CGPoint.thirdButtonPoint
                self.footerButtons[button.tag - 3].center = CGPoint.secondButtonPoint
                self.footerButtons[button.tag - 4].center = CGPoint.firstButtonPoint
            }) { (_) in
                completion()
            }
        } else {
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
                self.footerButtons[button.tag + 1].center = CGPoint.fourthButtonPoint
                self.footerButtons[button.tag + 2].center = CGPoint.fifthButtonPoint
            }) { (_) in
                completion()
            }
        }
    }

    func removeFifth(_ button: UIButton, completion : @escaping () -> Void) {
        if button.tag > 4 {
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
                self.footerButtons[button.tag - 1].center = CGPoint.fifthButtonPoint
                self.footerButtons[button.tag - 2].center = CGPoint.fourthButtonPoint
                self.footerButtons[button.tag - 3].center = CGPoint.thirdButtonPoint
                self.footerButtons[button.tag - 4].center = CGPoint.secondButtonPoint
                self.footerButtons[button.tag - 5].center = CGPoint.firstButtonPoint
            }) { (_) in
                completion()
            }
        } else {
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
                self.footerButtons[button.tag + 1].center = CGPoint.fifthButtonPoint
            }) { (_) in
                completion()
            }
        }
    }
}

