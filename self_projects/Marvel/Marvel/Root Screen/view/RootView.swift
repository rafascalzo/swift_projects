//
//  RootView.swift
//  Marvel
//
//  Created by rafaeldelegate on 7/26/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit
import Lottie
class RootView: UIView {
    
    struct Constants {
        static let screenSize:CGSize = UIScreen.main.bounds.size
        static let logoAnimationViewWidth : CGFloat = Constants.screenSize.width * 0.85
        static let logoAnimationViewHeight : CGFloat = Constants.screenSize.height * 0.85
        static let logoAnimationViewName = "black-deadpool"
    }
    
    // MARK :- ViewDelegate
    weak var delegate : RootViewDelegate?
    
    //MARK :- Components
    let animationContainerView : UIView = {
        let view = UIView()
        view.backgroundColor = .rootBackgroundColor
        return view
    }()
    let loadingAnimation:AnimationView = {
        let animation = AnimationView()
        animation.setupAnimation(named: Constants.logoAnimationViewName, withSpeed: nil, loopMode: .loop, size: UIScreen.main.bounds.size)
        animation.loopMode = .loop
        return animation
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    fileprivate func setupView() {
        
        addSubview(animationContainerView)
        animationContainerView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        animationContainerView.addSubview(loadingAnimation)
        loadingAnimation.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(Constants.logoAnimationViewWidth)
            make.height.equalTo(Constants.logoAnimationViewHeight)
        }
        
        loadingAnimation.play()
    }
    func setupNavigation() {
        delegate?.setupNavigation()
    }

}
