//
//  ViewNewMarker.swift
//  Full Square
//
//  Created by Fulltrack Mobile on 08/08/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//
//enum MenuOptions {
//
//    case camera
//    case library
//    case savedPhotosAlbum
//}
import UIKit

class ViewNewMarker: UIView {
    
    struct Constants {
        static let screenSize : CGRect = UIScreen.main.bounds
        static let mapHeaderHeight : CGFloat = Constants.screenSize.height * 0.1
        static let formHeightOffset : CGFloat = Constants.screenSize.height * 0.6
        static let fieldHeight : CGFloat = Constants.screenSize.height * 0.05
    }
    
    var delegate : ViewAnnotationFormDelegate?
    
    let labelTitle : UILabel = {
        let label = UILabel()
        label.text = "Pin configuration"
        label.textColor = .black
        label.sizeToFit()
        return label
    }()
    var imageViewPlace : UIImageView = {
        let photo = UIImageView()
        photo.layer.masksToBounds = true
        photo.setupCircularComponent(radius: 100)
        photo.setupLightBorders(withColor: .black)
        photo.contentMode = .scaleAspectFill
        photo.backgroundColor = .clear
        return photo
    }()
    var buttonSelectMediaOrigin : UIButton = {
        let button = UIButton()
        button.addCenterImage(named: "avatar", withMargin: 12)
        button.addTarget(self, action: #selector(addPhoto(_:)), for: .touchUpInside)
        button.setupLightBorders(withColor: .black)
        button.setupLightLayer()
        button.makeCircular(with: 60)
        return button
    }()
    var buttonSelectPhotoFromCamera : UIButton = {
        let button = UIButton()
        button.addCenterImage(named: "camera", withMargin: 12)
        button.alpha = 0
        button.addTarget(self, action: #selector(takeAPicture(_:)), for: .touchUpInside)
        button.setupLightBorders(withColor: .black)
        button.setupLightLayer()
        button.makeCircular(with: 60)
        return button
    }()
    var buttonSelectPhotoFromLibrary : UIButton = {
        let button = UIButton()
        button.addCenterImage(named: "gallery", withMargin: 12)
        button.alpha = 0
        button.addTarget(self, action: #selector(goToLibrary(_:)), for: .touchUpInside)
        button.makeCircular(with: 60)
        button.setupLightBorders(withColor: .black)
        button.setupLightLayer()
        return button
    }()
    var buttonCancelPhotoSelect : UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "stop"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        button.alpha = 0
        button.addTarget(self, action: #selector(CancelPhotoSelect(_:)), for: .touchUpInside)
        button.makeCircular(with: 60)
        button.setupLightBorders(withColor: .black)
        button.setupLightLayer()
        return button
    }()
    var textFieldTitle : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "Title"
        textField.setupLightLayer()
        textField.textColor = .black
        return textField
    }()
    var textFieldLocationName : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.placeholder = "Location name"
        textField.setupLightLayer()
        return textField
    }()
    var textFieldAdress : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.placeholder = "Adress"
        textField.setupLightLayer()
        return textField
    }()
    var textFieldNumber : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.placeholder = "N"
        textField.setupLightLayer()
        return textField
    }()
    var textFieldCategory : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.placeholder = "Category"
        textField.setupLightLayer()
        return textField
    }()
    var formContainerView : UIView = {
        let view = UIView()
        return view
    }()
    
    // MARK:- Header
    let headerContainerView : UIView = {
        let view = UIView()
        return view
    }()
    let backgroundImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "background-blue")
        return image
    }()
    var buttonBack : UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(backToPreviousController(_:)), for: .touchUpInside)
        button.addCenterImage(named: "arrow_left", withMargin: 6)
        button.setupLightBorders(withColor: .black)
        button.setupLightLayer()
        return button
    }()
    var buttonSavePin : UIButton = {
        let button = UIButton()
        button.setTitle("Save Pin", for: .normal)
        button.backgroundColor = UIColor(red: 68/255, green: 69/255, blue: 255/255, alpha: 1)
        button.addTarget(self, action: #selector(savePin(_:)), for: .touchUpInside)
        button.layer.cornerRadius = 15
        return button
    }()
    @objc func savePin(_ sender : Any){
        delegate?.savePin()
    }
    @objc func backToPreviousController(_ sender : Any){
        delegate?.backToPreviousController()
    }
    @objc func goToLibrary(_ sender : Any){
        delegate?.selectMediaOrigin(.library)
        dismissMediaOptions()
    }
    @objc func takeAPicture(_ sender : Any){
        delegate?.selectMediaOrigin(.camera)
        dismissMediaOptions()
    }
    @objc func addPhoto(_ sender : Any){
        showMediaOptions()
        //delegate?.addPhoto()
    }
    @objc func CancelPhotoSelect(_ sender : Any){
        dismissMediaOptions()
    }
    
    func checkImageStatus() {
        //        if self.imageViewPlace.image != nil {
        //            if self.buttonSelectMediaOrigin.title(for: .normal) == "+"{
        //                self.buttonSelectMediaOrigin.setTitle(nil, for: .normal)
        //                self.buttonSelectMediaOrigin.setTitle("Edit", for: .normal)
        //                self.layoutIfNeeded()
        //            }
        //        }
        // change icon image for state
    }
    
    func dismissMediaOptions() {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.buttonSelectPhotoFromCamera.transform = CGAffineTransform.identity
            self.buttonSelectPhotoFromCamera.alpha = 0
            self.buttonSelectPhotoFromLibrary.transform = CGAffineTransform.identity
            self.buttonSelectPhotoFromLibrary.alpha = 0
            self.buttonCancelPhotoSelect.transform = CGAffineTransform.identity
            self.buttonCancelPhotoSelect.alpha = 0
        })
    }
    
    // MARK: - View Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    // https://www.youtube.com/watch?v=HfsRs7Z9NNs
    // https://learnappmaking.com/pass-data-between-view-controllers-swift-how-to/#back-delegation
    // https://www.raywenderlich.com/425-mapkit-tutorial-overlay-views
    // https://www.raywenderlich.com/548-mapkit-tutorial-getting-started
    
    fileprivate func setupView() {
        addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        addSubview(headerContainerView)
        headerContainerView.snp.makeConstraints { (make) in
            make.topMargin.equalTo(CGFloat.defaultGuide)
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(50)
        }
        headerContainerView.addSubview(buttonBack)
        buttonBack.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leadingMargin.equalTo(CGFloat.padding)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        headerContainerView.addSubview(labelTitle)
        labelTitle.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        addSubview(imageViewPlace)
        imageViewPlace.snp.makeConstraints { (make) in
            make.top.equalTo(headerContainerView.snp.bottom).offset(7)
            make.centerX.equalToSuperview()
            make.height.equalTo(200)
            make.width.equalTo(200)
        }
        addSubview(buttonSelectMediaOrigin)
        buttonSelectMediaOrigin.snp.makeConstraints { (make) in
            make.top.equalTo(imageViewPlace.snp.bottom).offset(7)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalTo(60)
        }
        addSubview(buttonSelectPhotoFromCamera)
        buttonSelectPhotoFromCamera.snp.makeConstraints { (make) in
            make.top.equalTo(imageViewPlace.snp.bottom).offset(7)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalTo(60)
            
        }
        addSubview(buttonSelectPhotoFromLibrary)
        buttonSelectPhotoFromLibrary.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageViewPlace.snp.bottom).offset(7)
            make.height.equalTo(60)
            make.width.equalTo(60)
        }
        addSubview(buttonCancelPhotoSelect)
        buttonCancelPhotoSelect.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageViewPlace.snp.bottom).offset(7)
            make.height.equalTo(60)
            make.width.equalTo(60)
        }
        addSubview(buttonSavePin)
        buttonSavePin.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().inset(CGFloat.defaultGuide)
            make.leadingMargin.equalTo(CGFloat.padding)
            make.trailingMargin.equalTo(-CGFloat.padding)
            make.height.equalTo(60)
        }
        addSubview(formContainerView)
        formContainerView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(Constants.formHeightOffset)
            make.leadingMargin.equalTo(CGFloat.padding)
            make.trailingMargin.equalTo(-CGFloat.padding)
            make.bottom.equalTo(buttonSavePin.snp.top).offset(30)
        }
        formContainerView.addSubview(textFieldTitle)
        textFieldTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(12)
            make.leadingMargin.equalTo(CGFloat.padding)
            make.trailingMargin.equalTo(-CGFloat.padding)
            make.height.equalTo(Constants.fieldHeight)
        }
        formContainerView.addSubview(textFieldLocationName)
        textFieldLocationName.snp.makeConstraints { (make) in
            make.top.equalTo(textFieldTitle.snp.bottom).offset(12)
            make.leadingMargin.equalTo(CGFloat.padding)
            make.trailingMargin.equalTo(-CGFloat.padding)
            make.height.equalTo(Constants.fieldHeight)
        }
        formContainerView.addSubview(textFieldNumber)
        textFieldNumber.snp.makeConstraints { (make) in
            make.top.equalTo(textFieldLocationName.snp.bottom).offset(12)
            make.trailingMargin.equalTo(-CGFloat.padding)
            make.height.equalTo(Constants.fieldHeight)
            make.width.equalTo(40)
        }
        formContainerView.addSubview(textFieldAdress)
        textFieldAdress.snp.makeConstraints { (make) in
            make.centerY.equalTo(textFieldNumber)
            make.leadingMargin.equalTo(CGFloat.padding)
            make.trailing.equalTo(textFieldNumber.snp.leading).offset(10)
            make.height.equalTo(Constants.fieldHeight)
        }
        formContainerView.addSubview(textFieldCategory)
        textFieldCategory.snp.makeConstraints { (make) in
            make.top.equalTo(textFieldAdress.snp.bottom).offset(12)
            make.leadingMargin.equalTo(CGFloat.padding)
            make.trailingMargin.equalTo(-CGFloat.padding)
            make.height.equalTo(Constants.fieldHeight)
        }
        
    }
    
    func showMediaOptions(){
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
            
            self.buttonSelectPhotoFromCamera.transform = CGAffineTransform(translationX: -75, y: 50)
            self.buttonSelectPhotoFromCamera.alpha = 1
            self.buttonSelectPhotoFromLibrary.transform = CGAffineTransform(translationX: 0, y: 75)
            self.buttonSelectPhotoFromLibrary.alpha = 1
            self.buttonCancelPhotoSelect.transform = CGAffineTransform(translationX: 75, y: 50)
            self.buttonCancelPhotoSelect.alpha = 1
            
        })
    }
}



