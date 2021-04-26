//
//  ViewNewMarker.swift
//  Full Square
//
//  Created by Fulltrack Mobile on 08/08/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//
enum MenuOptions {
    case camera
    case library
    case savedPhotosAlbum
}
import UIKit

class ViewForm : UIView {
    
    // MARK:- Constants
    struct Constants {
        static let device = UIDevice.current.userInterfaceIdiom
        static let screenSize : CGRect = UIScreen.main.bounds
        static let formHeightOffset : CGFloat = Constants.screenSize.height * 0.6
        static let textFieldNumberWidth : CGFloat = Constants.screenSize.width * 0.11
        static let imageViewPlaceHeight = Constants.device == .phone ? Constants.screenSize.width * 0.6 : Constants.screenSize.width * 0.6
        static let scrollViewSize = CGSize(width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height + 200))
    }
    
    // MARK:- Attributes
    var delegate : ViewMarkerFormDelegate?
    var textFields : Array<UITextField> = []
    
    var containerScrollView : UIView = {
        let containerView = UIView()
        return containerView
    }()
    
    let scrollView : UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.contentSize = Constants.scrollViewSize
//        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    let headerContainerView : UIView = {
        let view = UIView()
        return view
    }()
    let labelTitle : UILabel = {
        let label = UILabel()
        label.setBasic("Pin Configuration", .textLargeFont, .black, .center)
        return label
    }()
    let backgroundImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "background-white")
        return image
    }()
    let buttonBack : UIButton = {
        let button = UIButton()
        button.addShadow(.shadowDarkColor, shadowOptions: .bottom)
        button.makeCircular(with: CGFloat.defaultCircularButtonSize)
        button.addCenterImage(named: "arrow-left", withMargin: 7, backgroundColor: .grayColor, size: button.intrinsicContentSize)
        button.addTarget(self, action: #selector(backToPreviousController(_:)), for: .touchUpInside)
        return button
    }()
    var imageViewPlace : UIImageView = {
        let photo = UIImageView()
        photo.layer.masksToBounds = true
        photo.backgroundColor = .clear
        photo.contentMode = .scaleAspectFill
        photo.setupLightBorders(withColor: .black)
        photo.layer.cornerRadius = 15
        return photo
    }()
    var buttonSelectMediaOrigin : UIButton = {
        let button = UIButton()
        button.addCenterImage(named: "pencil", withMargin: 7, backgroundColor: .grayColor, size: button.intrinsicContentSize)
        button.addShadow( .shadowDarkColor, shadowOptions: .bottom) 
        button.makeCircular(with: CGFloat.defaultCircularButtonSize)
        button.addTarget(self, action: #selector(showMediaOptions(_:)), for: .touchUpInside)
        return button
    }()
    var buttonSelectPhotoFromCamera : UIButton = {
        let button = UIButton()
        button.alpha = 0
        button.addShadow(.shadowDarkColor, shadowOptions: .bottom)
        button.makeCircular(with: CGFloat.defaultCircularButtonSize)
        button.addCenterImage(named: "photo-camera", withMargin: 7, backgroundColor: .grayColor, size: button.intrinsicContentSize)
        button.addTarget(self, action: #selector(selectPhotoFromCamera(_:)), for: .touchUpInside)
        return button
    }()
    var buttonSelectPhotoFromLibrary : UIButton = {
        let button = UIButton()
        button.alpha = 0
        button.makeCircular(with: CGFloat.defaultCircularButtonSize)
        button.addShadow(.shadowDarkColor, shadowOptions: .bottom)
        button.addCenterImage(named: "picture", withMargin: 7, backgroundColor: .grayColor, size: button.intrinsicContentSize)
        button.addTarget(self, action: #selector(selectPhotoFromLibrary(_:)), for: .touchUpInside)
        return button
    }()
    var buttonCancelPhotoSelect : UIButton = {
        let button = UIButton()
        button.alpha = 0
        button.makeCircular(with: CGFloat.defaultCircularButtonSize)
        button.addShadow(.shadowDarkColor, shadowOptions: .bottom)
        button.addCenterImage(named: "upload", withMargin: 7, backgroundColor: .grayColor, size: button.intrinsicContentSize)
        button.addTarget(self, action: #selector(cancelPhotoSelect(_:)), for: .touchUpInside)
        return button
    }()
    var buttonNewCategory : UIButton = {
        let button = UIButton()
        button.addShadow(.shadowDarkColor, shadowOptions: .bottom)
        button.makeCircular(with: CGFloat.defaultCircularButtonSize)
        button.addCenterImage(named: "plus", withMargin: 7, backgroundColor: .grayColor, size: button.intrinsicContentSize)
        button.addTarget(self, action: #selector(addNewCategory(_:)), for: .touchUpInside)
        return button
    }()
    // TextForm
    var textFieldCategory : UITextField = {
        let textField = UITextField()
        textField.buildSketchWith(tag: 1, text: "Click to select category", .black, .center, .grayColor)
        textField.isExclusiveTouch = true
        textField.makeCircular(with: CGFloat.defaultCircularButtonSize)
        textField.addShadow(.shadowDarkColor, shadowOptions: .bottom)
        textField.moveCursor(10)
        return textField
    }()
    
    var textFieldPlaceName : UITextField = {
        let textField = UITextField()
        textField.buildSketchWith(tag: 2, placeholder: "Place name", UIFont.textMediumFont, .black, .left, .grayColor)
        textField.makeCircular(with: CGFloat.defaultCircularButtonSize)
        textField.addShadow(.shadowDarkColor, shadowOptions: .bottom)
        textField.moveCursor(10)
        return textField
    }()
    var textFieldSite : UITextField = {
        let textField = UITextField()
        textField.buildSketchWith(tag: 3, placeholder: "Site", UIFont.textMediumFont ,.black, .left, .grayColor)
        textField.makeCircular(with: CGFloat.defaultCircularButtonSize)
        textField.addShadow(.shadowDarkColor, shadowOptions: .bottom)
        textField.moveCursor(10)
        return textField
    }()
    var telephonePickerView : UIPickerView = {
       let pickerView = UIPickerView()
        // Main view rounded border
        pickerView.layer.borderWidth = 0
        pickerView.backgroundColor = .clear
        pickerView.makeCircular(with: CGFloat.defaultCircularButtonSize)
        return pickerView
    }()
    var textFieldTelephone : UITextField = {
        let textField = UITextField()
        textField.buildSketchWith(tag: 4, placeholder: "Telephone", UIFont.textMediumFont ,.black, .left, .grayColor)
        textField.makeCircular(with: CGFloat.defaultCircularButtonSize)
        textField.addShadow(.shadowDarkColor, shadowOptions: .bottom)
        textField.moveCursor(100)
        textField.keyboardType = UIKeyboardType.phonePad
        return textField
    }()
    var buttonSaveMarker : UIButton = {
        let button = UIButton()
        button.addShadow(.shadowDarkColor, shadowOptions: .bottom)
        button.makeCircular(with: CGFloat.defaultCircularButtonSize)
        button.addCenterImage(named: "save-file-option", withMargin: nil, backgroundColor: .grayColor, size: button.intrinsicContentSize)
        button.addTarget(self, action: #selector(saveMarker(_:)), for: .touchUpInside)
        return button
    }()
    
    var formContainerView : UIView = {
        let view = UIView()
        return view
    }()
    var listButtonTableView : UITableView = {
        let table = UITableView(frame: .init(), style: .plain)
        table.layer.masksToBounds = true
        table.backgroundColor = .grayColor
        table.alpha = 0
        table.delaysContentTouches = true
        table.layer.cornerRadius = 15
        return table
    }()
    
    // MARK: - View Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupGestures()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK:- Methods
    fileprivate func setupView() {
        addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.width.equalTo(Constants.scrollViewSize.width)
            make.height.equalTo(Constants.scrollViewSize.height)
            make.centerX.centerY.equalToSuperview()
        }
        scrollView.addSubview(containerScrollView)
        containerScrollView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(Constants.scrollViewSize.width)
            make.height.equalTo(Constants.scrollViewSize.height)
        }
        
        containerScrollView.addSubview(headerContainerView)
        headerContainerView.snp.makeConstraints { (make) in
            make.topMargin.equalTo(CGFloat.paddingLarge)
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(50)
        }
        headerContainerView.addSubview(buttonBack)
        buttonBack.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leadingMargin.equalTo(CGFloat.paddingSmall)
            make.height.equalTo(CGFloat.defaultCircularButtonSize)
            make.width.equalTo(CGFloat.defaultCircularButtonSize)
        }
        headerContainerView.addSubview(labelTitle)
        labelTitle.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        containerScrollView.addSubview(imageViewPlace)
        imageViewPlace.snp.makeConstraints { (make) in
            make.top.equalTo(headerContainerView.snp.bottom).offset(7)
            make.leadingMargin.equalTo(CGFloat.paddingLarge)
            make.trailingMargin.equalTo(-CGFloat.paddingLarge)
            make.height.equalTo(Constants.imageViewPlaceHeight)
        }
        
        containerScrollView.addSubview(buttonSelectMediaOrigin)
        buttonSelectMediaOrigin.snp.makeConstraints { (make) in
            make.top.equalTo(imageViewPlace.snp.bottom).offset(CGFloat.paddingSmall)
            make.centerX.equalToSuperview()
            make.height.equalTo(CGFloat.defaultCircularButtonSize)
            make.width.equalTo(CGFloat.defaultCircularButtonSize)
        }
       
        containerScrollView.addSubview(buttonSelectPhotoFromCamera)
        buttonSelectPhotoFromCamera.snp.makeConstraints { (make) in
            make.top.equalTo(imageViewPlace.snp.bottom).offset(CGFloat.paddingSmall)
            make.centerX.equalToSuperview()
            make.height.equalTo(CGFloat.defaultCircularButtonSize)
            make.width.equalTo(CGFloat.defaultCircularButtonSize)
        }
        containerScrollView.addSubview(buttonSelectPhotoFromLibrary)
        buttonSelectPhotoFromLibrary.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageViewPlace.snp.bottom).offset(CGFloat.paddingSmall)
            make.height.equalTo(CGFloat.defaultCircularButtonSize)
            make.width.equalTo(CGFloat.defaultCircularButtonSize)
        }
        containerScrollView.addSubview(buttonCancelPhotoSelect)
        buttonCancelPhotoSelect.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageViewPlace.snp.bottom).offset(CGFloat.paddingSmall)
            make.height.equalTo(CGFloat.defaultCircularButtonSize)
            make.width.equalTo(CGFloat.defaultCircularButtonSize)
        }
        
        containerScrollView.addSubview(formContainerView)
        formContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(buttonSelectMediaOrigin.snp.bottom).offset(CGFloat.paddingSmall)
            make.leadingMargin.equalTo(CGFloat.paddingSmall)
            make.trailingMargin.equalTo(-CGFloat.paddingSmall)
            make.bottom.equalToSuperview().offset(-CGFloat.paddingSmall)
        }
        formContainerView.addSubview(buttonNewCategory)
        buttonNewCategory.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(CGFloat.defaultCircularButtonSize)
            make.width.equalTo(CGFloat.defaultCircularButtonSize)
        }
        formContainerView.addSubview(textFieldCategory)
        textFieldCategory.snp.makeConstraints { (make) in
            make.centerY.equalTo(buttonNewCategory.snp.centerY)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().inset(CGFloat.paddingSmall + CGFloat.defaultCircularButtonSize)
            make.height.equalTo(CGFloat.defaultCircularButtonSize)
        }
        textFields.append(textFieldCategory)
        containerScrollView.addSubview(listButtonTableView)
        listButtonTableView.snp.makeConstraints { (make) in
            make.top.equalTo(textFieldCategory.snp.bottom).offset(CGFloat.paddingInsideItens)
            make.leadingMargin.equalTo(CGFloat.paddingSmall)
            make.trailingMargin.equalTo(-CGFloat.paddingSmall)
            make.bottom.equalToSuperview().inset(CGFloat.paddingSmall)
        }
        formContainerView.addSubview(textFieldPlaceName)
        textFieldPlaceName.snp.makeConstraints { (make) in
            make.top.equalTo(textFieldCategory.snp.bottom).offset(CGFloat.paddingInsideItens)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(CGFloat.defaultCircularButtonSize)
        }
        textFields.append(textFieldPlaceName)
        formContainerView.addSubview(textFieldSite)
        textFieldSite.snp.makeConstraints { (make) in
            make.top.equalTo(textFieldPlaceName.snp.bottom).offset(CGFloat.paddingInsideItens)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(CGFloat.defaultCircularButtonSize)
        }
        textFields.append(textFieldSite)
       
        formContainerView.addSubview(textFieldTelephone)
        textFieldTelephone.snp.makeConstraints { (make) in
            make.top.equalTo(textFieldSite.snp.bottom).offset(CGFloat.paddingInsideItens)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(CGFloat.defaultCircularButtonSize)
        }
        textFieldTelephone.addSubview(telephonePickerView)
        telephonePickerView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalTo(100)
        }
        textFields.append(textFieldTelephone)
        containerScrollView.addSubview(buttonSaveMarker)
        buttonSaveMarker.snp.makeConstraints { (make) in
            make.top.equalTo(textFieldTelephone.snp.bottom).offset(CGFloat.paddingInsideItens)
            make.leading.equalToSuperview().offset(CGFloat.paddingSmall)
            make.trailing.equalToSuperview().inset(CGFloat.paddingSmall)
            make.height.equalTo(CGFloat.defaultCircularButtonSize)
        }
    }
    
    @objc func backToPreviousController(_ sender : Any){
        delegate?.backToPreviousController()
    }
    @objc func showMediaOptions(_ sender : Any){
        showMediaOptions()
    }
    @objc func selectPhotoFromLibrary(_ sender : Any){
        delegate?.selectMediaOrigin(.library)
    }
    @objc func selectPhotoFromCamera(_ sender : Any){
        delegate?.selectMediaOrigin(.camera)
    }
    @objc func cancelPhotoSelect(_ sender : Any){
        delegate?.cancelPhotoSelect(sender)
    }
    @objc func addNewCategory(_ sender : Any){
        delegate?.addNewDiscipline(sender)
    }
    @objc func saveMarker(_ sender : Any){
        delegate?.savePin(sender)
    }
    
    fileprivate func setupGestures(){
        
        addTapGestureRecognizer {
            self.delegate?.checkLayoutStatus()
        }
        textFieldCategory.addTapGestureRecognizer {
            self.delegate?.showTableOptions(self.textFieldCategory)
        }
    }
    func showTable() {
        bringSubviewToFront(listButtonTableView)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.buttonSaveMarker.alpha = 0
            self.listButtonTableView.alpha = 1
        })
    }
    func hideTable(){
        sendSubviewToBack(listButtonTableView)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.buttonSaveMarker.alpha = 1
            self.listButtonTableView.alpha = 0
        })
    }
    func showMediaOptions(){
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
            self.buttonSelectPhotoFromCamera.alpha = 1
            self.buttonCancelPhotoSelect.alpha = 1
            self.buttonSelectPhotoFromLibrary.alpha = 1
            self.buttonSelectMediaOrigin.alpha = 0
            self.buttonSelectPhotoFromLibrary.transform = CGAffineTransform(translationX: -75, y: 0)
            self.buttonCancelPhotoSelect.transform = CGAffineTransform(translationX: 75, y: 0)
        })
    }
    func dismissMediaOptions() {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
            self.buttonSelectPhotoFromLibrary.transform = CGAffineTransform.identity
            self.buttonCancelPhotoSelect.transform = CGAffineTransform.identity
            self.buttonSelectPhotoFromCamera.alpha = 0
            self.buttonCancelPhotoSelect.alpha = 0
            self.buttonSelectPhotoFromLibrary.alpha = 0
            self.buttonSelectMediaOrigin.alpha = 1
        })
    }
}



