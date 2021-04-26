//
//  MainView.swift
//  Spacing
//
//  Created by rvsm on 10/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MainCell"
private let collectionViewHeight:CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 600: 1200

class MainView: UICollectionViewController, MainViewProtocol {
    
    var presenter: MainPresenterProtocol?
    
    var scenes = [[Scene(title: "picture_of_the_day".localized, scene: .PICTURE_OF_THE_DAY, imageName: "nebula")], [Scene(title: "mars_rover".localized, scene: .MARS, imageName: "mars_rover")], [Scene(title: "epic".localized, scene: .EPIC, imageName: "epic")],[Scene(title: "earth".localized, scene: .EARTH, imageName: "earth")] , [Scene(title: "image_and_video_library".localized, scene: .IMAGE_AND_VIDEO_LIBRARY, imageName: "image_and_video_library")], [Scene(title: "maps".localized, scene: .MAPS, imageName: "image_and_video_library")]]
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: View Lifecycle
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barStyle = .black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func loadView() {
        super.loadView()
        let cell = UINib(nibName: "MainCell", bundle: .main)
        collectionView.register(cell, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MainWireframe.createModule(viewRef: self)
        presenter?.viewDidLoad()
    }
    
    func render() {
        //navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.graffiti]
        
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return scenes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return scenes[section].count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MainCell
        
        let scene = scenes[indexPath.section][indexPath.row]
        let shadow = NSShadow()
        shadow.shadowBlurRadius = 4
        shadow.shadowColor = UIColor.black
        shadow.shadowOffset = .zero
        let attributes:[NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 0.90, alpha: 1), .shadow: shadow, .font: UIFont.boldSystemFont(ofSize: 32)]
        let mutableText = NSMutableAttributedString(string: scene.title, attributes: attributes)
        cell.setupView(attribute: mutableText, image: UIImage(named: scene.imageName)?.withRenderingMode(.alwaysOriginal))
//        cell.titleLabel.attributedText = mutableText
//        cell.backgroundImageView.image = UIImage(named: scene.imageName)?.withRenderingMode(.alwaysOriginal)
        //cell.selectionStyle = .none
        //cell.backgroundColor = .purple
        
        cell.clipsToBounds = true
        let path = UIBezierPath(roundedRect: cell.bounds, byRoundingCorners: [.topLeft,.topRight , .bottomLeft, .bottomRight], cornerRadii: CGSize(width: 8, height: 8))
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        cell.layer.mask = shape
        return cell
    }
        
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("test")
        let scene = scenes[indexPath.section][indexPath.item]
        presenter?.pushTo(scene: scene)
    }
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
}

extension MainView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
