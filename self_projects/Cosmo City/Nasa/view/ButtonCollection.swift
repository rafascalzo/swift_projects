//
//  ButtonCollection.swift
//  Cosmo City
//
//  Created by rafaeldelegate on 7/8/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

class ButtonCollection: UIButton {
    
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
        self.addTarget(SpaceViewController.instanceMethod(for: #selector(SpaceViewController().goToCollection(_:))), action: #selector(SpaceViewController().goToCollection(_:)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupAnchors(_ view:UIView){
        let guide = view.safeAreaLayoutGuide
        anchor(top: guide.topAnchor, leading: nil, trailing: guide.trailingAnchor, bottom: nil,padding: .init(top: Constants.padding, left: 0, bottom: 0, right: -Constants.padding), size: .init(width: Constants.width, height: Constants.width))
    }
    

}
