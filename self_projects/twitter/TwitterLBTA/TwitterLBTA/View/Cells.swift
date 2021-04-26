//
//  Cells.swift
//  TwitterLBTA
//
//  Created by rafael-estagio on 03/06/19.
//  Copyright © 2019 rafael-estagio. All rights reserved.
//

import LBTAComponents

class UserHeader : DatasourceCell {
    override func setupViews() {
        super.setupViews()
        backgroundColor = .yellow
    }
}

class UserFooter : DatasourceCell{
    override func setupViews() {
        super.setupViews()
        backgroundColor = .orange
    }
}

class UserCell: DatasourceCell{
    
    override var datasourceItem: Any?{
        didSet{
            nameLabel.text = datasourceItem as? String
        }
    }
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.text = "TEST"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = .red
        addSubview(nameLabel)
        
        nameLabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}
