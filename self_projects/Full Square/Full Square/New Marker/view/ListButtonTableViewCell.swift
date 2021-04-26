//
//  ListButtonTableViewCell.swift
//  Full Square
//
//  Created by Fulltrack Mobile on 12/08/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import UIKit

class ListButtonTableViewCell: UITableViewCell {
 
    var iconImage : UIImageView = {
        let image = UIImageView()
        return image
    }()
    var imageName : UILabel = {
       let label = UILabel()
        label.sizeToFit()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .grayColor
        addSubview(iconImage)
        iconImage.snp.makeConstraints { (make) in
            make.top.bottom.leading.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.height * 0.05)
        }
        addSubview(imageName)
        imageName.snp.makeConstraints { (make) in
            make.leading.equalTo(iconImage.snp.trailing).offset(12)
            make.centerY.equalToSuperview()
        }
    }
    override func prepareForReuse() {
        // invoke superclass implementation
        super.prepareForReuse()
        // reset (hide) the checkmark label
        if self.accessoryType == .checkmark{
        self.accessoryType = .none
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupCell(_ title : String?, imageName : String?){
        
        if let title = title {
            self.imageName.text = title
        } else {
            self.imageName.text = "no info"
        }
        
        if let imageName = imageName{
            self.iconImage.image = UIImage(named: imageName)
            self.iconImage.image?.accessibilityIdentifier = imageName
        } else {
            iconImage.image = UIImage(named: "plus")
        }
    }
}
