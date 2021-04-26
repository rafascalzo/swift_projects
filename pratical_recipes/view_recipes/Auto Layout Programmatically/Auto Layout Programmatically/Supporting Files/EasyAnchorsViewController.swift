//
//  ViewController.swift
//  Auto Layout Programmatically
//
//  Created by rafaeldelegate on 7/6/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

class EasyAnchorsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let navigation = navigationController else {return}
        navigation.isNavigationBarHidden = true
        
        let redView = UIView()
        redView.backgroundColor = .red
        let blueView = UIView()
        blueView.backgroundColor = .blue
        let greenView = UIView()
        greenView.backgroundColor = .green
        
        [redView,blueView,greenView].forEach{view.addSubview($0)}
        view.backgroundColor = .white
        
        if #available(iOS 11, *) {
            let horizontalAutoSize = (view.frame.width - (3 * 16)) / 3
            let guide = view.safeAreaLayoutGuide
            redView.anchor(top: guide.topAnchor, leading: nil, trailing: guide.trailingAnchor, bottom: nil, padding: .init(top: 0, left: 16, bottom: 0, right: -16), size: .init(width: horizontalAutoSize, height: horizontalAutoSize))
            
            
            blueView.anchor(top: redView.bottomAnchor, leading: nil, trailing: redView.trailingAnchor, bottom: nil, padding: .init(top: 16, left: 0, bottom: 0, right: 0))
            blueView.anchorSize(to: redView)
            
            greenView.anchor(top: redView.topAnchor, leading: guide.leadingAnchor, trailing: redView.leadingAnchor, bottom: blueView.bottomAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: -16))
            
        } else {
            let standardSpacing: CGFloat = 8.0
            redView.anchor(top: view.topAnchor, leading: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, bottom: nil, padding: .init(top: standardSpacing, left: 16, bottom: 0, right: -16), size: .init(width: 100, height: 100))
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .default
    }
}

extension UIView {
    
    func fillSuperView (){
        anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, trailing: superview?.trailingAnchor, bottom: superview?.bottomAnchor)
    }
    
    func anchorSize(to view:UIView){
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, padding: UIEdgeInsets = UIEdgeInsets.zero, size: CGSize = CGSize.zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing,constant: padding.right).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: padding.bottom).isActive = true
        }
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}

