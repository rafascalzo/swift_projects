//
//  ButtonBack.swift
//  Cosmo City
//
//  Created by rafaeldelegate on 7/8/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

class ButtonBack: UIButton {

    struct Constants {
        static let device = UIDevice.current.userInterfaceIdiom
        static let imageName = "ufo"
        static let padding:CGFloat = device == .phone ? 10 : 20
        static let width:CGFloat = device == .phone ? 30 : 60
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setImage(UIImage(named: Constants.imageName), for: .normal)
        contentMode = .scaleAspectFit
        translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = self.frame.width / 2
        self.addTarget(PicturesViewController.instanceMethod(for: #selector(PicturesViewController().backToNasa(_:))), action: #selector(PicturesViewController().backToNasa(_:)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupAnchors(_ view:UIView){
        let guide = view.safeAreaLayoutGuide
        anchor(top: guide.topAnchor, leading: guide.leadingAnchor, trailing: nil, bottom: nil,padding: .init(top: Constants.padding, left: Constants.padding, bottom: 0, right: 0), size: .init(width: Constants.width, height: Constants.width))
    }
    


}
