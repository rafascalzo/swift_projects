//
//  SuccessViewController.swift
//  auto-layout
//
//  Created by Rafael on 6/16/19.
//  Copyright © 2019 Fulltime. All rights reserved.
//

import UIKit

class SuccessViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let navigation = navigationController{
            navigation.navigationBar.barStyle = .black
            navigation.navigationBar.isTranslucent = false
            navigation.isNavigationBarHidden = true
            
        }
        
        viewMain.addSubview(labelSuccess)
        viewMain.addSubview(imageViewHappy)
        viewMain.addSubview(labelReadyToStart)
        viewMain.addSubview(buttonContinue)
        view.addSubview(viewMain)
        
        setupLayout()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    let viewMain : UIView = {
        let view = UIView()
        view.backgroundColor = HexToUIColor().hexStringToUIColor(hex: "0ABE5E")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let labelSuccess : UILabel = {
        let label = UILabel()
        label.text = "SUCESSO!"
        label.textColor = .white
        label.font = UIFont(name: "Lato-Bold", size: UIDevice.current.userInterfaceIdiom == .phone ? 46 : 92)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imageViewHappy: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "si-dark"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let labelReadyToStart : UILabel = {
        let label = UILabel()
        label.text = "Efetuamos todas as verificações seu FStreet está pronto para ser utilizado."
        label.numberOfLines = 3
        label.textColor = .white
        label.font = UIFont(name: "Lato-Regular", size: UIDevice.current.userInterfaceIdiom == .phone ? 18 : 36)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let buttonContinue : UIButton = {
        let button = UIButton.init()
        button.setTitle("CONTINUAR", for: .normal)
        button.titleLabel?.font = UIFont(name: "Lato-Bold", size: UIDevice.current.userInterfaceIdiom == .phone ? 20 : 40)
        button.setTitleColor(HexToUIColor().hexStringToUIColor(hex: "0ABE5E"), for: .normal)
        button.layer.cornerRadius = 15
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(test(sender:)), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func test(sender: UIButton){
        print("DUUUUUUUUDE")
        if let navigation = navigationController{
            navigation.pushViewController(ImeiViewController(), animated: true)
        }
    }
    
    
    
    fileprivate func setupLayout(){
        
        view.backgroundColor = .black
        view.safeAreaLayoutGuide
        let device = UIDevice.current.userInterfaceIdiom
        
        viewMain.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        viewMain.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        viewMain.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        viewMain.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        labelSuccess.topAnchor.constraint(equalTo: viewMain.topAnchor, constant: UIDevice.current.userInterfaceIdiom == .phone ? 53 : 106).isActive = true
        labelSuccess.rightAnchor.constraint(equalTo: viewMain.rightAnchor).isActive = true
        labelSuccess.leftAnchor.constraint(equalTo: viewMain.leftAnchor).isActive = true
        labelSuccess.widthAnchor.constraint(equalToConstant: UIDevice.current.userInterfaceIdiom == .phone ? 216 : 432).isActive = true
        labelSuccess.heightAnchor.constraint(equalToConstant: UIDevice.current.userInterfaceIdiom == .phone ? 55 : 110).isActive = true
        
        imageViewHappy.centerXAnchor.constraint(equalTo: viewMain.centerXAnchor).isActive = true
        imageViewHappy.topAnchor.constraint(equalTo: labelSuccess.bottomAnchor, constant: device == .phone ? 6.44 : 12.88).isActive = true
        imageViewHappy.widthAnchor.constraint(equalToConstant: UIDevice.current.userInterfaceIdiom == .phone ? 318.18 : 636.36).isActive = true
        imageViewHappy.heightAnchor.constraint(equalToConstant: UIDevice.current.userInterfaceIdiom == .phone ? 260.7 : 521.4).isActive = true
        
        labelReadyToStart.topAnchor.constraint(equalTo: imageViewHappy.bottomAnchor, constant: UIDevice.current.userInterfaceIdiom == .phone ? 34.86 : 69.72).isActive = true
        labelReadyToStart.rightAnchor.constraint(equalTo: viewMain.rightAnchor).isActive = true
        labelReadyToStart.leftAnchor.constraint(equalTo: viewMain.leftAnchor).isActive = true
        labelReadyToStart.widthAnchor.constraint(equalToConstant: UIDevice.current.userInterfaceIdiom == .phone ? 252 : 304).isActive = true
        labelReadyToStart.heightAnchor.constraint(equalToConstant: UIDevice.current.userInterfaceIdiom == .phone ? 66 : 122).isActive = true
        
        buttonContinue.topAnchor.constraint(equalTo: labelReadyToStart.bottomAnchor, constant: device == .phone ? 50 : 100).isActive = true
        buttonContinue.rightAnchor.constraint(equalTo: viewMain.rightAnchor, constant: device == .phone ? -20 : -40).isActive = true
        buttonContinue.leftAnchor.constraint(equalTo: viewMain.leftAnchor, constant: device == .phone ? 20 : 40).isActive = true
        buttonContinue.widthAnchor.constraint(equalToConstant: device == .phone ? 270 : 520).isActive = true
        buttonContinue.heightAnchor.constraint(equalToConstant: device == .phone ? 50 : 100).isActive = true
        
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
