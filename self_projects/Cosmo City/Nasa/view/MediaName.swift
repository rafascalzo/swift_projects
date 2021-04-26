//
//  MediaName.swift
//  Cosmo City
//
//  Created by rafaeldelegate on 7/7/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

class MediaName: UILabel {
    
    struct Constants {
        static let text = ""
        static let device = UIDevice.current.userInterfaceIdiom
        static let padding:CGFloat =  Constants.device == .phone ? 16 : 32
        static let paddingTop:CGFloat = Constants.device == .phone ? 16 : 32
        static let height:CGFloat = Constants.device == .phone ? 44 : 88
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBasicLabel(nil, UIFont.fontForTitles, UIColor.labelTitleColor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupAnchor(view:UIView, parent:UILabel){
        
        let horizontalAutoSize = view.frame.width - (2 * Constants.padding)
        let guide = view.safeAreaLayoutGuide
        
        self.anchor(top: parent.bottomAnchor, leading: guide.leadingAnchor, trailing: guide.trailingAnchor, bottom: nil, padding: .init(top: Constants.paddingTop, left: Constants.padding, bottom: 0, right: -Constants.padding), size: .init(width: horizontalAutoSize, height: Constants.height))
    }
}
