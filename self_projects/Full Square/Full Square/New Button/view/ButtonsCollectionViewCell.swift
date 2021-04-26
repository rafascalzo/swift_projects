//
//  ButtonsCollectionViewCell.swift
//  Full Square
//
//  Created by Fulltrack Mobile on 13/08/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import UIKit

class ButtonsCollectionViewCell: UICollectionViewCell {
    
    var image : UIImageView = {
       let image = UIImageView()
        //image.
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    var name : String = "RAFAEL TESTS"
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(image)
        image.snp.makeConstraints { (make) in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupCell(_ imageName : String, margin:CGFloat){
        image.image = UIImage(named: imageName)
        image.image?.accessibilityIdentifier = imageName
        image.accessibilityIdentifier = imageName
    }
}
