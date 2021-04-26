//
//  UIButton+BasicButtonAutoLayoutSetup.swift
//  f-street
//
//  Created by rafael-estagio on 19/06/19.
//  Copyright © 2019 Fulltime. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func setButtonAutoLayout(_ title:String = "", _ font:String = "Lato-Regular", _ fontSize:CGFloat = 14, _ fontColor:String = "000000",_ backgroundColor:String = "FFFFFF" ,cornerRadius:CGFloat = 0.0)-> UIButton{
        let button = self
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont(name: font, size: UIDevice.current.userInterfaceIdiom == .phone ? fontSize : fontSize*2)
        button.setTitleColor(HexToUIColor().hexStringToUIColor(hex: fontColor), for: .normal)
        button.layer.cornerRadius = cornerRadius
        button.backgroundColor = HexToUIColor().hexStringToUIColor(hex: backgroundColor)
        button.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    func setImagedButtonAutoLayout(_ imageName:String) -> UIButton {
        let button = self
        button.setImage(UIImage(named: imageName), for: .normal)
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}
