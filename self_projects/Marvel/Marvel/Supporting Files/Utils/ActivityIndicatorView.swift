//
//  ActivityIndicatorView.swift
//  Marvel
//
//  Created by rafaeldelegate on 7/20/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import Foundation
import UIKit

class ActivityIndicatorView {
    
    let view : UIView = {
        let view = UIView()
        view.addCellBlur()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 15
        return view
    }()
    
    var activityIndicatorView : UIActivityIndicatorView = {
        var activityIView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        return activityIView
    }()
    
    let controller:UIViewController
    
    init(controller:UIViewController){
        self.controller = controller
    }
    
    func showHUD(){
        controller.view.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(120)
        }
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        activityIndicatorView.startAnimating()
    }
    
    func dismissHUD(){
        activityIndicatorView.stopAnimating()
        self.view.removeFromSuperview()
    }
    
}



