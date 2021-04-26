////    let nibName = "HeroDetailsView"
//    var view : UIView!
//    var delegate : UIViewController?
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        xibSetUp()
//        backgroundColor = .blue
//
//    }
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        xibSetUp()
//    }
//
//    init(delegate:UIViewController) {
//        super.init(frame: .init())
//        self.delegate = delegate
//    }
//
//    func xibSetUp() {
//        view = loadViewFromNib()
//        view.frame = self.bounds
//        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
//        addSubview(view)
//    }
//
//    func loadViewFromNib() ->UIView {
//        let bundle = Bundle(for: type(of: self))
//        let nib = UINib(nibName: nibName, bundle: bundle)
//        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
//        return view
//    }

//  HeroDetailsView.swift
//  Marvel
//
//  Created by rafaeldelegate on 7/12/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit
import SnapKit

public class HeroDetailsView: UIView {
    
    struct Constants {
        static let device = UIDevice.current.userInterfaceIdiom
        static let screenFrame = UIScreen.main.bounds
        static let guide = UIScreen.main.bounds.height * 0.02
        static let imageHeight:CGFloat = Constants.device == .phone ? Constants.screenFrame.height * 0.42 : Constants.screenFrame.height * 0.52
        static let padding:CGFloat = Constants.device == .phone ? Constants.screenFrame.width * 0.025 : Constants.screenFrame.width * 0.05
        static let homeButtonHeight:CGFloat = Constants.device == .phone ? Constants.screenFrame.width * 0.07 : Constants.screenFrame.width * 0.07
    }
    weak var delegate : HeroDetailsViewDelegate?
    
    var bluredView : UIView = {
        let view = UIView()
        return view
    }()
    
    var cardImage : UIImageView = {
        let image = UIImageView()
        image.setColoredLightBorders(color: .white)
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    var labelImageTitle: UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "", textColor: .white, font: UIFont.titleFontLarge, backgroundColor: .clear)
        return label
    }()
    
    var textViewDescription : UITextView = {
        let textView = UITextView()
        textView.setBasics(text: "TEST", font: .textFontLarge, textColor: .white, allignment: .center, .clear, isEditable: false, withInteraction: true)
        return textView
    }()
    
    var homeButton : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(backToHome(_:)), for: .touchUpInside)
        button.setImage(UIImage(named: "back-arrow"), for: .normal)
        return button
    }()
    
    let backgroundImage:UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "marvel")
        image.contentMode = .scaleAspectFill
        image.alpha = 0.5
        return image
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        backgroundColor = .clear
        bluredView.addBlur()
        addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        addSubview(homeButton)
        homeButton.snp.makeConstraints { (make) in
            make.topMargin.equalTo(Constants.guide)
            make.leadingMargin.equalTo(Constants.padding)
            make.width.equalTo(Constants.homeButtonHeight)
            make.height.equalTo(Constants.homeButtonHeight)
        }
        addSubview(bluredView)
        bluredView.snp.makeConstraints { (make) in
            make.top.equalTo(homeButton.snp.bottom).offset(Constants.padding)
            make.trailingMargin.equalTo(-Constants.padding)
            make.leadingMargin.equalTo(Constants.padding)
            make.height.equalTo(Constants.imageHeight)
        }
        addSubview(cardImage)
        cardImage.snp.makeConstraints { (make) in
            make.topMargin.equalTo(bluredView)
            make.trailingMargin.equalTo(bluredView)
            make.leadingMargin.equalTo(bluredView)
            make.height.equalTo(bluredView)
        }
        
        addSubview(labelImageTitle)
        labelImageTitle.snp.makeConstraints { (make) in
            make.top.equalTo(cardImage.snp.bottom).offset(Constants.padding)
            make.trailingMargin.equalTo(-Constants.padding)
            make.leadingMargin.equalTo(Constants.padding)
            //make.height.equalTo(30)
        }
        
        addSubview(textViewDescription)
        textViewDescription.snp.makeConstraints { (make) in
            make.top.equalTo(labelImageTitle.snp.bottom).offset(Constants.padding)
            make.leadingMargin.equalTo(Constants.padding)
            make.trailingMargin.equalTo(-Constants.padding)
            make.bottom.equalToSuperview().inset(Constants.padding)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func backToHome(_ sender: Any){
        delegate?.backToPreviowsController()
    }
    
    func configView(_ character: CharacterDataWrapper.CharacterDataContainer.Character) -> Void {
        
        let urlPath = "\(character.thumbnail?.path! ?? "").\(character.thumbnail?.extension! ?? "")"
        let url = URL(string: urlPath)
        let data = try? Data(contentsOf: url!)
        
        self.cardImage.image = UIImage(data: data!)
        self.labelImageTitle.text = character.name
        self.textViewDescription.text = character.description
    }
    
}
