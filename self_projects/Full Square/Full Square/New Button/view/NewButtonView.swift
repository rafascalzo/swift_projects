//
//  NewButtonView.swift
//  Full Square
//
//  Created by Fulltrack Mobile on 13/08/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import UIKit

class NewButtonView: UIView {
    
    //MARK: - Constants
    struct Constants {
        
        static let device = UIDevice.current.userInterfaceIdiom
        static let screenSize = UIScreen.main.bounds.size
        static let viewHeaderHeight:CGFloat = Constants.device == .phone ? 35 : 70
        static let headerHeight = Constants.screenSize.width * 0.12
        static let collectionViewHeight = Constants.screenSize.height * 0.5
        static let buttonImageWidth = Constants.screenSize.width * 0.2
        static let imageContainerViewWidth:CGFloat = Constants.device == .phone ? 180 : 360
    }
    
    //MARK: - Attributes
    var textFields : Array<UITextField> = []
    
    let imageBackground : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "background-white")
        image.contentMode = UIView.ContentMode.scaleAspectFill
        return image
    }()
    var delegate : NewButtonViewDelegate?
    
    let headerView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    let backButton : UIButton = {
        let button = UIButton()
        button.addCenterImage(named: "arrow-left", withMargin: 7, backgroundColor: .grayColor, size: button.intrinsicContentSize)
        button.addShadow(.shadowDarkColor, shadowOptions: .bottom)
        button.makeCircular(with: CGFloat.defaultCircularButtonSize)
        button.addTarget(self, action: #selector(backToPreviousController(_:)), for: .touchUpInside)
        return button
    }()
    var buttonSaveMarker : UIButton = {
        let button = UIButton()
        button.addShadow(.shadowDarkColor, shadowOptions: .bottom)
        button.makeCircular(with: CGFloat.defaultCircularButtonSize)
        button.addCenterImage(named: "save-file-option", withMargin: nil, backgroundColor: .grayColor, size: button.intrinsicContentSize)
        button.addTarget(self, action: #selector(saveButton(_:)), for: .touchUpInside)
        return button
    }()
    var titleLabel : UILabel = {
        let label = UILabel()
        label.setBasic("Configure Button", .tittleLargeFont, .black, .center)
        return label
    }()
    var buttonTitleTextField : UITextField = {
        let textField = UITextField()
        textField.buildSketchWith(tag: nil, placeholder: "Button name", UIFont.titleMediumFont, .black, .center, .grayColor)
        textField.layer.cornerRadius = 15
        textField.addShadow(.black, shadowOptions: .bottom)
        return textField
    }()
    var imageContainerView : UIView = {
        let view = UIView()
        view.backgroundColor = .grayColor
        view.makeCircular(with: Constants.imageContainerViewWidth)
        return view
    }()
    var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.addCenterImageView(named: "photo-camera", with: CGSize(width: Constants.imageContainerViewWidth, height: Constants.imageContainerViewWidth))
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    var buttonsCollectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: .init(), collectionViewLayout: .init())
        collectionView.backgroundColor = .clear
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = CGFloat.paddingSmall
        layout.minimumLineSpacing = CGFloat.paddingSmall
        collectionView.collectionViewLayout = layout
        return collectionView
    }()

    // MARK: - View Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Methods
    fileprivate func setupView() {
        
        addTapGesture(in: self)
        addSubview(imageBackground)
        imageBackground.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        addSubview(headerView)
        headerView.snp.makeConstraints { (make) in
            make.topMargin.equalTo(CGFloat.paddingLarge)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(Constants.headerHeight)
        }
        headerView.addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leadingMargin.equalTo(CGFloat.paddingSmall)
            make.height.equalTo(CGFloat.defaultCircularButtonSize)
            make.width.equalTo(CGFloat.defaultCircularButtonSize)
        }
        headerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(CGFloat.paddingSmall)
            make.trailing.equalToSuperview().inset(CGFloat.paddingSmall)
            make.height.equalToSuperview()
        }
        
        addSubview(imageContainerView)
        imageContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom).offset(CGFloat.paddingSmall)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(Constants.imageContainerViewWidth)
        }
        imageContainerView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.height.width.equalTo(Constants.buttonImageWidth)
        }
        addSubview(buttonTitleTextField)
        buttonTitleTextField.snp.makeConstraints { (make) in
            make.top.equalTo(imageContainerView.snp.bottom).offset(3 * CGFloat.paddingSmall)
            make.leadingMargin.equalTo(CGFloat.paddingSmall)
            make.trailingMargin.equalTo(-CGFloat.paddingSmall)
            make.height.equalTo(Constants.viewHeaderHeight)
        }
        textFields.append(buttonTitleTextField)
        addSubview(buttonSaveMarker)
        buttonSaveMarker.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-CGFloat.paddingLarge)
            make.leading.equalToSuperview().offset(CGFloat.paddingSmall)
            make.trailing.equalToSuperview().inset(CGFloat.paddingSmall)
            make.height.equalTo(CGFloat.defaultCircularButtonSize)
        }
        addSubview(buttonsCollectionView)
        buttonsCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(buttonTitleTextField.snp.bottom).offset(CGFloat.paddingSmall)
            make.leadingMargin.equalTo(CGFloat.paddingSmall)
            make.trailingMargin.equalTo(-CGFloat.paddingSmall)
            make.bottom.equalTo(buttonSaveMarker.snp.top).offset(-CGFloat.paddingSmall)
        }
    }
    @objc func saveButton(_ sender : Any){
        delegate?.saveButton(sender)
    }
    @objc func handleImageView(_ sender : Any){
        delegate?.handleTapGesture(sender)
    }
    @objc func backToPreviousController(_ sender : Any) {
        delegate?.backToPreviousController(sender)
    }
    func addTapGesture(in view:UIView){
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleImageView(_:)))
        recognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(recognizer)
    }
}
