//
//  TitleLabel.swift
//  Cosmo City
//
//  Created by rafaeldelegate on 7/6/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

class TitleLabel: UILabel {
    
    struct Constants {
        static let text = "Nasa Pic of the Day"
        static let device = UIDevice.current.userInterfaceIdiom
        static let padding:CGFloat =  Constants.device == .phone ? 16 : 32
        static let paddingTop:CGFloat = Constants.device == .phone ? 26 : 52
        static let height:CGFloat = Constants.device == .phone ? 44 : 88
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupBasicLabel(Constants.text, UIFont.fontForTitles!, UIColor.labelTitleColor)
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupAnchor(view:UIView){
        
        let horizontalAutoSize = view.frame.width - (2 * Constants.padding)
        let guide = view.safeAreaLayoutGuide
        
        self.anchor(top: guide.topAnchor, leading: guide.leadingAnchor, trailing: guide.trailingAnchor, bottom: nil, padding: .init(top: Constants.paddingTop, left: Constants.padding, bottom: 0, right: -Constants.padding), size: .init(width: horizontalAutoSize, height: Constants.height))
    }
}
