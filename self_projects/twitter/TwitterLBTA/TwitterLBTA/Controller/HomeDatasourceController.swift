//
//  HomeDatasourceController.swift
//  TwitterLBTA
//
//  Created by rafael-estagio on 03/06/19.
//  Copyright © 2019 rafael-estagio. All rights reserved.
//

import LBTAComponents



class HomeDatasourceController : DatasourceController{
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        let homeDataSource = HomeDataSource()
        self.datasource = homeDataSource
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return(CGSize(width: view.frame.width, height: 100))
    }
}
