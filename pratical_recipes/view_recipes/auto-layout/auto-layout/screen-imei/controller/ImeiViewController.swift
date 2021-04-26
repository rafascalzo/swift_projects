//
//  ImeiViewController.swift
//  auto-layout
//
//  Created by Rafael on 6/15/19.
//  Copyright © 2019 Fulltime. All rights reserved.
//

import UIKit

class ImeiViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navigation = navigationController{
            navigation.navigationBar.barStyle = .black
            navigation.navigationBar.isTranslucent = false
            navigation.isNavigationBarHidden = true
        }
        
        view.backgroundColor = .black
        view.addSubview(viewMain)
        viewMain.addSubview(alertImageView)
        viewMain.addSubview(labelTitle)
        viewMain.addSubview(labelSubtitle)
        viewMain.addSubview(labelDecription)
        viewMain.addSubview(buttonImei)
        viewMain.addSubview(labelValidade)
        viewMain.addSubview(buttonVerifyAndContinue)
        setupLayout()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    let viewMain : UIView = {
        let view = UIView()
        view.backgroundColor = HexToUIColor().hexStringToUIColor(hex: "CC0808")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let alertImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "si-ligth"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let labelTitle : UILabel = {
        let label = UILabel()
        label.text = "FStreet"
        label.textColor = .white
        label.font = UIFont(name: "Prototype", size: UIDevice.current.userInterfaceIdiom == .phone ? 30 : 60)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelSubtitle : UILabel = {
        let label = UILabel()
        label.text = "Alarme Comunitário"
        label.textColor = .white
        label.font = UIFont(name: "Lato-Regular", size: UIDevice.current.userInterfaceIdiom == .phone ? 14 : 28)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelDecription : UILabel = {
        let label = UILabel()
        label.text = "Para realizar o seu cadastro é preciso gerar um IMEI e cadastrar no seu perfil web"
        label.numberOfLines = 4
        label.textColor = .white
        label.font = UIFont(name: "Lato-Regular", size: UIDevice.current.userInterfaceIdiom == .phone ? 18 : 36)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let buttonImei : UIButton = {
        let button = UIButton.init()
        button.setTitle("GERAR IMEI AGORA", for: .normal)
        button.titleLabel?.font = UIFont(name: "Lato-Bold", size: UIDevice.current.userInterfaceIdiom == .phone ? 18 : 36)
        button.setTitleColor(HexToUIColor().hexStringToUIColor(hex: "CC0808"), for: .normal)
        button.layer.cornerRadius = 15
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(generateImei(sender:)), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func generateImei(sender: UIButton){
        print("hey what's up")
    }
    
    let labelValidade : UILabel = {
        let label = UILabel()
        label.text = "Já inseriu o código na web, clique em prosseguir para validar"
        label.numberOfLines = 4
        label.textColor = .white
        label.font = UIFont(name: "Lato-Regular", size: UIDevice.current.userInterfaceIdiom == .phone ? 18 : 36)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let buttonVerifyAndContinue : UIButton = {
        let button = UIButton.init()
        button.setTitle("VERIFICAR E CONTINUAR", for: .normal)
        button.titleLabel?.font = UIFont(name: "Lato-Bold", size: UIDevice.current.userInterfaceIdiom == .phone ? 20 : 40)
        button.setTitleColor(HexToUIColor().hexStringToUIColor(hex: "CC0808"), for: .normal)
        button.layer.cornerRadius = 15
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(verifyAndContinue(sender:)), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func verifyAndContinue(sender: UIButton){
        print("DUUUUUUUUDE")
        if let navigation = navigationController{
            navigation.pushViewController(AlertsViewController(), animated: true)
        }
    }
    
    
 
    
    fileprivate func setupLayout(){
        
        let device = UIDevice.current.userInterfaceIdiom
        
        viewMain.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        viewMain.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        viewMain.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        viewMain.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        alertImageView.centerXAnchor.constraint(equalTo: viewMain.centerXAnchor).isActive = true
        alertImageView.topAnchor.constraint(equalTo: viewMain.topAnchor, constant: device == .phone ? 23.28 : 46.56).isActive = true
        alertImageView.widthAnchor.constraint(equalToConstant: UIDevice.current.userInterfaceIdiom == .phone ? 33.75 : 67.5).isActive = true
        alertImageView.heightAnchor.constraint(equalToConstant: UIDevice.current.userInterfaceIdiom == .phone ? 34.1 : 68.2).isActive = true
        
        
        labelTitle.topAnchor.constraint(equalTo: alertImageView.bottomAnchor, constant: UIDevice.current.userInterfaceIdiom == .phone ? 10.31 : 20.62).isActive = true
        labelTitle.rightAnchor.constraint(equalTo: viewMain.rightAnchor).isActive = true
        labelTitle.leftAnchor.constraint(equalTo: viewMain.leftAnchor).isActive = true
        labelTitle.widthAnchor.constraint(equalToConstant: UIDevice.current.userInterfaceIdiom == .phone ? 105 : 210).isActive = true
        labelTitle.heightAnchor.constraint(equalToConstant: UIDevice.current.userInterfaceIdiom == .phone ? 40 : 80).isActive = true
        
        
        labelSubtitle.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: device == .phone ? 3.86 : 7.72).isActive = true
        labelSubtitle.rightAnchor.constraint(equalTo: viewMain.rightAnchor).isActive = true
        labelSubtitle.leftAnchor.constraint(equalTo: viewMain.leftAnchor).isActive = true
        labelSubtitle.widthAnchor.constraint(equalToConstant: device == .phone ? 123 : 246).isActive = true
        labelSubtitle.heightAnchor.constraint(equalToConstant: device == .phone ? 30 : 60).isActive = true
        
        labelDecription.topAnchor.constraint(equalTo: labelSubtitle.bottomAnchor, constant: device == .phone ? 20.17 : 40.34).isActive = true
        labelDecription.leftAnchor.constraint(equalTo: viewMain.leftAnchor, constant: device == .phone ? 20 : 40).isActive = true
        labelDecription.rightAnchor.constraint(equalTo: viewMain.rightAnchor,constant: device == .phone ? -20 : -40).isActive = true
        labelDecription.widthAnchor.constraint(equalToConstant: 270).isActive = true
        labelDecription.heightAnchor.constraint(equalToConstant: device == .phone ? 66 : 132).isActive = true
        
        buttonImei.topAnchor.constraint(equalTo: labelDecription.bottomAnchor, constant: device == .phone ? 20 : 30).isActive = true
        buttonImei.rightAnchor.constraint(equalTo: viewMain.rightAnchor, constant: device == .phone ? -20 : -40).isActive = true
        buttonImei.leftAnchor.constraint(equalTo: viewMain.leftAnchor, constant: device == .phone ? 20 : 40).isActive = true
        buttonImei.widthAnchor.constraint(equalToConstant: 270).isActive = true
        buttonImei.heightAnchor.constraint(equalToConstant: device == .phone ? 50 : 100).isActive = true
        
        labelValidade.topAnchor.constraint(equalTo: buttonImei.bottomAnchor, constant: device == .phone ? 25 : 50).isActive = true
        labelValidade.rightAnchor.constraint(equalTo: viewMain.rightAnchor, constant: device == .phone ? -20 : -40).isActive = true
        labelValidade.leftAnchor.constraint(equalTo: viewMain.leftAnchor, constant: device == .phone ? 20 : 40).isActive = true
        labelValidade.widthAnchor.constraint(equalToConstant: device == .phone ? 270 : 520).isActive = true
        labelValidade.heightAnchor.constraint(equalToConstant: device == .phone ? 50 : 100).isActive = true
        
        buttonVerifyAndContinue.topAnchor.constraint(equalTo: labelValidade.bottomAnchor, constant: device == .phone ? 30 : 60).isActive = true
        buttonVerifyAndContinue.rightAnchor.constraint(equalTo: viewMain.rightAnchor, constant: device == .phone ? -20 : -40).isActive = true
        buttonVerifyAndContinue.leftAnchor.constraint(equalTo: viewMain.leftAnchor, constant: device == .phone ? 20 : 40).isActive = true
        buttonVerifyAndContinue.widthAnchor.constraint(equalToConstant: device == .phone ? 250 : 500).isActive = true
        buttonVerifyAndContinue.heightAnchor.constraint(equalToConstant: device == .phone ? 50 : 100).isActive = true
    }
    
    
}
