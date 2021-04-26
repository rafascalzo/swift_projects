//
//  CGPointsExtension.swift
//  Full Square
//
//  Created by rafaeldelegate on 8/1/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import Foundation

import UIKit

enum Points : Int {
    case firstButtonPoint = 1
    case secondButtonPoint = 2
    case thirdButtonPoint = 3
    case fourthButtonPoint = 4
    case fifthButtonPoint = 5
}

extension CGPoint {
    
    static let leftHiddenButtonPoint = CGPoint(x: 0 - (CGFloat.iconSpacing), y: CGFloat.footerHeight / 2)
    
    static let firstButtonPoint = CGPoint(x: CGFloat.iconSpacing + (CGFloat.iconHeight / 2), y: CGFloat.footerHeight / 2)
    
    static let secondButtonPoint = CGPoint(x: (UIScreen.main.bounds.width / 2 - (CGFloat.iconSpacing + CGFloat.iconWidth)) , y: CGFloat.footerHeight / 2)
    
    static let thirdButtonPoint = CGPoint(x: UIScreen.main.bounds.width / 2, y: CGFloat.footerHeight / 2)
    
    static let fourthButtonPoint = CGPoint(x: (UIScreen.main.bounds.width / 2 + (CGFloat.iconSpacing + CGFloat.iconWidth)), y: CGFloat.footerHeight / 2)
    
    static let fifthButtonPoint = CGPoint(x: UIScreen.main.bounds.width - (CGFloat.iconSpacing + (CGFloat.iconWidth / 2)), y: CGFloat.footerHeight / 2)
    
    static  let rightHiddenButtonPoint = CGPoint(x: (UIScreen.main.bounds.width + CGFloat.iconSpacing), y: CGFloat.footerHeight / 2)
    
    static  let trashPoint = CGPoint(x: (UIScreen.main.bounds.width / 2), y: UIScreen.main.bounds.height - (5 * CGFloat.paddingLarge) )
    
}
