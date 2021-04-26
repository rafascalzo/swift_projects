//
//  PicturesViewController.swift
//  Cosmo City
//
//  Created by rafaeldelegate on 7/7/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

class PicturesViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource{
    
    let mediaList:Array<Media> = NASADAO().retrieveMedia()
    let buttonBack = ButtonBack()
    let customCellIdentifier = "cellIdentifier"
    let picturesCollectionView = PicturesCollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.init())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupCollection()
        setupView()
    }
    
    fileprivate func setupCollection(){
        picturesCollectionView.delegate = self
        picturesCollectionView.dataSource = self
    }
    
    fileprivate func setupNavigation(){
        if let navigation = navigationController {
            navigation.isNavigationBarHidden = true
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle{
        return.lightContent
    }
    

    fileprivate func setupView(){
        
        view.backgroundColor = .backgroundColor
        view.addSubview(picturesCollectionView)
        picturesCollectionView.setupAnchor(view: view)
        view.addSubview(buttonBack)
        buttonBack.setupAnchors(view)
    }
    
    @objc func backToNasa(_ sender:UIButton){
        if let navigation = navigationController{
            navigation.popViewController(animated: true)
        }
    }

}

extension PicturesViewController {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediaList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: customCellIdentifier, for: indexPath) as! PicturesCollectionViewCell
        let media = mediaList[indexPath.row]
        cell.configureCell(media: media)
        return cell
    }
}
