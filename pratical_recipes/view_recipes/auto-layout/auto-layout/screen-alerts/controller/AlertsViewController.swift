//
//  AlertsViewController.swift
//  auto-layout
//
//  Created by Rafael on 6/15/19.
//  Copyright © 2019 Fulltime. All rights reserved.
//

import UIKit
import Foundation

class AlertsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navigation = navigationController{
            //navigation.navigationBar.barStyle = .black
            navigation.navigationBar.isTranslucent = false
            navigation.navigationBar.barTintColor = .white
            navigation.isNavigationBarHidden = false
            }
        
        alertsCollectionView.delegate = self
        alertsCollectionView.dataSource = self
        alertsCollectionView.register(CellCollectionViewCell.self, forCellWithReuseIdentifier: customCellIdentifier)
        
        view.backgroundColor = HexToUIColor().hexStringToUIColor(hex: "E9E9E9")
        view.addSubview(labelHowTo)
        view.addSubview(alertsCollectionView)
        view.addSubview(buttonAcceptThermsOfUse)
        
        setupLayout()
        setupNavigationBarItems()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    private func setupNavigationBarItems(){
        let titleView : UIView = {
           let label = UILabel()
            label.text = "FStreet"
            label.textColor = .black
            label.font = UIFont(name: "Prototype", size: 26)
            label.frame = CGRect(x: 0, y: 0, width: 86, height: 31)
            return label
        }()
        titleView.widthAnchor.constraint(equalToConstant: 86).isActive = true
        titleView.heightAnchor.constraint(equalToConstant: 31).isActive = true
        
        navigationItem.titleView = titleView
        
        let rightIcon : UIView = {
            let leftButton = UIButton(type: .custom)
            leftButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
            leftButton.setImage(UIImage(named: "si-dark"), for: .normal)
            leftButton.addTarget(self, action: #selector(self.accessSettings(sender:)), for: .touchUpInside)
            leftButton.contentMode = .scaleAspectFit
            leftButton.translatesAutoresizingMaskIntoConstraints = false
            
            return leftButton
        }()
        
        rightIcon.widthAnchor.constraint(equalToConstant: 34).isActive = true
        rightIcon.heightAnchor.constraint(equalToConstant: 34).isActive = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightIcon)
        
        let leftIcon : UIView = {
           let leftButton = UIButton(type: .custom)
            leftButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
            leftButton.setImage(UIImage(named: "si-dark"), for: .normal)
            leftButton.addTarget(self, action: #selector(self.accessProfille(sender:)), for: .touchUpInside)
            leftButton.contentMode = .scaleAspectFit
            leftButton.translatesAutoresizingMaskIntoConstraints = false
          
            return leftButton
        }()
        
        leftIcon.widthAnchor.constraint(equalToConstant: 34).isActive = true
        leftIcon.heightAnchor.constraint(equalToConstant: 34).isActive = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftIcon)
    }
    
    @objc func accessProfille(sender: UIButton){
        print("hey what's up")
    }
    
    @objc func accessSettings(sender: UIButton){
        print("DUUUUUUDE")
    }
    
    let labelHowTo : UILabel = {
        let label = UILabel()
        label.text = "Pressione sem soltar para enviar um alerta"
        label.textColor = .black
        label.font = UIFont(name: "Lato-Regular", size: UIDevice.current.userInterfaceIdiom == .phone ? 14 : 28)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let customCellIdentifier = "cellIdentifier"
    
    // MAKR : - COLLECTION VIEW
    
    lazy var alertsCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        layout.scrollDirection = .vertical
        
        var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: customCellIdentifier, for: indexPath) as! CellCollectionViewCell
        return cell
    }
    
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        return UIDevice.current.userInterfaceIdiom == .phone ? CGSize(width: 130, height: 132.64) : CGSize(width: 260, height: 265.28)
    }
    
    let buttonAcceptThermsOfUse : UIButton = {
        let button = UIButton.init()
        button.setTitle("ACEITAR TERMOS DE USO", for: .normal)
        button.titleLabel?.font = UIFont(name: "Lato-Bold", size: UIDevice.current.userInterfaceIdiom == .phone ? 14 : 28)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(acceptThermsOfUse(sender:)), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func acceptThermsOfUse(sender: UIButton){
        print("hey what's up")
        if let navigation = navigationController{
            navigation.pushViewController(PermissionsViewController(), animated: true)
        }
    }

    fileprivate func setupLayout(){
        
        let device = UIDevice.current.userInterfaceIdiom
        
        labelHowTo.topAnchor.constraint(equalTo: view.topAnchor, constant: device == .phone ? 14 : 28).isActive = true
        labelHowTo.leftAnchor.constraint(equalTo: view.leftAnchor, constant: device == .phone ? 20 : 40).isActive = true
        labelHowTo.rightAnchor.constraint(equalTo: view.rightAnchor, constant: device == .phone ? -20 : -40).isActive = true
        labelHowTo.widthAnchor.constraint(equalToConstant: device == .phone ? 270 : 640).isActive = true
        labelHowTo.heightAnchor.constraint(equalToConstant: device == .phone ? 20 : 40).isActive = true
        
        alertsCollectionView.topAnchor.constraint(equalTo: labelHowTo.bottomAnchor, constant: device == .phone ? 16.1 : 32.2).isActive = true
        alertsCollectionView.bottomAnchor.constraint(equalTo: buttonAcceptThermsOfUse.topAnchor, constant: device == .phone ? -26 : -52).isActive = true
        alertsCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: device == .phone ? 20 : 40).isActive = true
        alertsCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant:  device == .phone ? -20 : -40).isActive = true
        alertsCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 15).isActive = true
        
        buttonAcceptThermsOfUse.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
       buttonAcceptThermsOfUse.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        buttonAcceptThermsOfUse.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        buttonAcceptThermsOfUse.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
       buttonAcceptThermsOfUse.heightAnchor.constraint(equalToConstant: device == .phone ? 50 : 100).isActive = true
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
