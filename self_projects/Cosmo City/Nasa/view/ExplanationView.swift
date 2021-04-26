//
//  ExplanationView.swift
//  Cosmo City
//
//  Created by rafaeldelegate on 7/7/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

class ExplanationView: UIView {
    
    var explanationTextView = UITextView()
    
    struct Constants {
        
        static let device = UIDevice.current.userInterfaceIdiom
        static let padding:CGFloat =  Constants.device == .phone ? 16 : 32
        static let paddingTop:CGFloat = Constants.device == .phone ? 26 : 52
        static let height:CGFloat = Constants.device == .phone ? 250 : 500
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBasicView(.clear)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupAnchors(top:UIView, view: UIView){
        
        let guide = view.safeAreaLayoutGuide
        
    anchor(top: top.bottomAnchor, leading: guide.leadingAnchor, trailing: guide.trailingAnchor, bottom: view.bottomAnchor,padding: .init(top: Constants.paddingTop, left: Constants.padding, bottom: -Constants.padding, right: -Constants.padding))
    }
    
    func setupTextView(text:String){
        
        addSubview(explanationTextView)
    
        explanationTextView.setupBasicTextView(text, UIFont.fontForExplanation!,UIColor.white , UIColor.clear)
        explanationTextView.isEditable = false
        explanationTextView.isSelectable = false
        
        explanationTextView.anchor(top: self.topAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, bottom: self.bottomAnchor)
    }
    
}
