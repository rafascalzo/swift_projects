//
//  MainCell.swift
//  Spacing
//
//  Created by FulltrackMobile on 10/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import UIKit

class MainCell: UICollectionViewCell {

    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupView(attribute: NSAttributedString, image: UIImage?) {
        titleLabel.attributedText = attribute
        backgroundImageView.image = image
    }
}
