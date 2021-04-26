//
//  PicturesCollectionView.swift
//  Cosmo City
//
//  Created by rafaeldelegate on 7/7/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

class PicturesCollectionView: UICollectionView {

    struct Constants {
        static let customCellIdentifier = "cellIdentifier"
        static let device = UIDevice.current.userInterfaceIdiom
        static let cellHeight:CGFloat = device == .phone ? 300 : 600
        static let padding:CGFloat =  Constants.device == .phone ? 16 : 32
        static let paddingTop:CGFloat = Constants.device == .phone ? 16 : 32
        static let height:CGFloat = Constants.device == .phone ? 44 : 88
        static let spaceInterItens:CGFloat = Constants.device == .phone ? 15 : 30
    }

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.register(PicturesCollectionViewCell.self, forCellWithReuseIdentifier: Constants.customCellIdentifier)       
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupAnchor(view:UIView){
        let guide = view.safeAreaLayoutGuide
        
        anchor(top: guide.topAnchor, leading: guide.leadingAnchor, trailing: guide.trailingAnchor, bottom: guide.bottomAnchor,padding: .init(top: Constants.padding, left: Constants.padding, bottom: -Constants.padding, right: -Constants.padding))
        
        let cellWidth = view.frame.width - (2 * Constants.padding)
        setupCellLayout(cellWidth: cellWidth)
    }
    
    func setupCellLayout(cellWidth:CGFloat){
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = Constants.spaceInterItens
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: cellWidth, height: Constants.cellHeight)
        
        self.collectionViewLayout = layout
    }
    
}
