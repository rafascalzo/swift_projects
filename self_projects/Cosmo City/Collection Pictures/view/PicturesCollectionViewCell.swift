//
//  PicturesCollectionViewCell.swift
//  Cosmo City
//
//  Created by rafaeldelegate on 7/7/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

class PicturesCollectionViewCell: UICollectionViewCell {
    
    var image = UIImageView()
    var title = UILabel()
    
    struct Constants {
        static let device = UIDevice.current.userInterfaceIdiom
        static let height:CGFloat = device == .phone ? 250 : 450
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    fileprivate func setupView(){
        backgroundColor = .lightGray
        layer.cornerRadius = 15
        layer.masksToBounds = true
        addSubview(image)
        image.setupBasicView(.white)
        image.translatesAutoresizingMaskIntoConstraints = false
        addSubview(title)
        title.setupBasicLabel(nil, .fontForCellTitle)
        title.translatesAutoresizingMaskIntoConstraints = false
        
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[image]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["image":image]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[image(\(Constants.height))]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["image" :image]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[labelTitle]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["labelTitle" : title]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-\(Constants.height)-[labelTitle]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["labelTitle" : title]))
        
    }
    
    
    func configureCell(media:Media){
        
        let url = URL(string: media.url!)
        let data = try? Data(contentsOf: url!)
        image.image = UIImage(data: data!)
        
        title.text = media.title
        title.layer.borderWidth = 2
        title.layer.borderColor = UIColor.black.cgColor
        title.textColor = .white
        backgroundColor = randomColor()
        
        
    }
    fileprivate func randomColor() -> UIColor{
        
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
   
    
   
}
