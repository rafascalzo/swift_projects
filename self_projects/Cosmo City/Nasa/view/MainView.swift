//
//  MainView.swift
//  Cosmo City
//
//  Created by rafaeldelegate on 7/7/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit
import Lottie

class MainView: UIView {
    
   
    var titleLabel = TitleLabel()
    var mediaNameLabel = MediaName()
    var mediaContainerView = MediaContainerView()
    var explanationView = ExplanationView()
    var loadAnimation = LoadingAnimationView()
 

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    fileprivate func setupLayout(){
        
        backgroundColor = .backgroundColor
        
        addSubview(loadAnimation)
        loadAnimation.center = self.center
        addSubview(titleLabel)
        titleLabel.setupAnchor(view: self)
        addSubview(mediaNameLabel)
        mediaNameLabel.setupAnchor(view: self, parent: titleLabel)
        addSubview(mediaContainerView)
        mediaContainerView.setupAnchor(top: mediaNameLabel, view: self)
        addSubview(explanationView)
        explanationView.setupAnchors(top: mediaContainerView, view: self)
        
    }
    
    func setAnchors(to view:UIView) {
        
        let guide = view.safeAreaLayoutGuide
        
        anchor(top: guide.topAnchor, leading: guide.leadingAnchor, trailing: guide.trailingAnchor, bottom: guide.bottomAnchor)
    }
}
