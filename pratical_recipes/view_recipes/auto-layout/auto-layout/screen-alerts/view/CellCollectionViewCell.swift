//
//  CellCollectionViewCell.swift
//  auto-layout
//
//  Created by Rafael on 6/15/19.
//  Copyright © 2019 Fulltime. All rights reserved.
//

import UIKit

class CellCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView : UIView = {
       let image = UIImageView(image: UIImage(named: "si-ligth"))
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    let viewCell : UIView = {
        
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let labelCell : UIView = {
           let device = UIDevice.current.userInterfaceIdiom
       let label = UILabel()
        label.text = "Huss"
        label.font = UIFont(name: "Lato-Bold", size: device == .phone ? 17 : 34)
        label.textColor = .black
        label.textAlignment = NSTextAlignment.center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupViews(){
        backgroundColor = .white
        addSubview(imageView)
        addSubview(viewCell)
        addSubview(labelCell)
        frame = CGRect(x: 0, y: 0, width: 155, height: 132)
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        let device = UIDevice.current.userInterfaceIdiom
        
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: device == .phone ? 20 : 40).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: device == .phone ? 51.79 : 103.58).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: device == .phone ? 51.79 : 103.58).isActive = true
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v1]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v1" : viewCell]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: device == .phone ? "V:|-85-[v1]|" : "V:|-190-[v1]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v1" : viewCell]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v2]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v2" : labelCell]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: device == .phone ? "V:|-85-[v2]|" : "V:|-190-[v2]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v2" : labelCell]))
        
    }
}
