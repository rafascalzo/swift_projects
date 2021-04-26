//
//  UILabel+BasicLabelSetup.swift
//  f-street
//
//  Created by rafael-estagio on 19/06/19.
//  Copyright © 2019 Fulltime. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    func setLabelAutoLayout(_ text:String = "", _ font:String = "Avenir-Regular", _ fontSize:CGFloat = 14, _ fontColor:String = "000000")-> UILabel{
        let label = self
        label.text = text
        label.font = UIFont(name: font, size: UIDevice.current.userInterfaceIdiom == .phone ? fontSize : fontSize*2)
        label.textColor = HexToUIColor().hexStringToUIColor(hex: fontColor)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}
