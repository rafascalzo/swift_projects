//
//  ResultsCollectionViewCell.swift
//  Marvel
//
//  Created by rafael-estagio on 11/07/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//
import SnapKit
import UIKit

class CollectionViewCellCharacters: UICollectionViewCell {
    
    struct Constants {
        static let device = UIDevice.current.userInterfaceIdiom
        
        static let cellHeight:CGFloat = UIScreen.main.bounds.height * 0.22
        static let imageHeight:CGFloat = device == .phone ? Constants.cellHeight * 0.85 : Constants.cellHeight * 0.80
        static let padding:CGFloat = device == .phone ? 16 : 32
    }
    
    var image : UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .clear
        return img
    }()
    var titleLabel : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "", textColor: .white, font: .titleFontSmall, backgroundColor: .clear, textAlignment: .center)
        label.numberOfLines = 1
        return label
    }()
    //    var title : UITextView = {
    //        let txt = UITextView()
    //        txt.setBasics(text: "SpiderMan", font: .titleFontSmall, textColor: .white, allignment: .center, .clear, isEditable: false, withInteraction: false)
    //        return txt
    //    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    fileprivate func setupView(){
        
        backgroundColor = .clear
        setColoredLightBorders(color: .black)
        layer.masksToBounds = true
        addCellBlur()
        
        addSubview(image)
        image.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(Constants.imageHeight)
        }
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(image.snp.bottom).inset(1.5)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalToSuperview().inset(1.5)
        }
    }
    
    func configureCell(_ title: String, _ image:CharacterDataWrapper.CharacterDataContainer.Character.Image){
        
        let urlPath = "\(image.path!).\(image.extension!)"
        guard let url = URL(string: urlPath) else {
            print("No url")
            return
        }
        let data = try? Data(contentsOf: url)
        self.image.image = UIImage(data: data!)
        self.titleLabel.text = title
        
    }
}
