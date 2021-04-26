//
//  PermissionsViewController.swift
//  auto-layout
//
//  Created by Rafael on 6/16/19.
//  Copyright © 2019 Fulltime. All rights reserved.
//

import UIKit

class PermissionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navigation = navigationController{
            navigation.navigationBar.barStyle = .black
            navigation.navigationBar.isTranslucent = false
            navigation.isNavigationBarHidden = true

        }
        
        view.addSubview(viewMain)
        viewMain.addSubview(alertImageView)
        viewMain.addSubview(labelTitle)
        viewMain.addSubview(labelSubtitle)
        viewMain.addSubview(labelTestCommunication)
        viewMain.addSubview(buttonTest)
        
        setupLayout()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    let viewMain : UIView = {
        let view = UIView()
        view.backgroundColor = HexToUIColor().hexStringToUIColor(hex: "2699FB")
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
    
    let labelTestCommunication : UILabel = {
        let label = UILabel()
        label.text = "Agora será preciso testar a comunicação e dar as permissões para o aplicativo funcionar corretamente."
        label.numberOfLines = 4
        label.textColor = .white
        label.font = UIFont(name: "Lato-Regular", size: UIDevice.current.userInterfaceIdiom == .phone ? 18 : 36)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let buttonTest : UIButton = {
        let button = UIButton.init()
        button.setTitle("VERIFICAR E CONTINUAR", for: .normal)
        button.titleLabel?.font = UIFont(name: "Lato-Bold", size: UIDevice.current.userInterfaceIdiom == .phone ? 20 : 40)
        button.setTitleColor(HexToUIColor().hexStringToUIColor(hex: "2699FB"), for: .normal)
        button.layer.cornerRadius = 15
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(test(sender:)), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func test(sender: UIButton){
        print("DUUUUUUUUDE")
        if let navigation = navigationController{
            navigation.pushViewController(SuccessViewController(), animated: true)
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
        
        alertImageView.centerXAnchor.constraint(equalTo: viewMain.centerXAnchor).isActive = true
        alertImageView.topAnchor.constraint(equalTo: viewMain.topAnchor, constant: device == .phone ? 43.28 : 86.56).isActive = true
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
        
        labelTestCommunication.topAnchor.constraint(equalTo: labelSubtitle.bottomAnchor, constant: device == .phone ? 66.17 : 132.34).isActive = true
        labelTestCommunication.leftAnchor.constraint(equalTo: viewMain.leftAnchor, constant: device == .phone ? 20 : 40).isActive = true
        labelTestCommunication.rightAnchor.constraint(equalTo: viewMain.rightAnchor,constant: device == .phone ? -20 : -40).isActive = true
        labelTestCommunication.widthAnchor.constraint(equalToConstant: 270).isActive = true
        labelTestCommunication.heightAnchor.constraint(equalToConstant: device == .phone ? 66 : 132).isActive = true
        
        buttonTest.topAnchor.constraint(equalTo: labelTestCommunication.bottomAnchor, constant: device == .phone ? 80 : 160).isActive = true
        buttonTest.rightAnchor.constraint(equalTo: viewMain.rightAnchor, constant: device == .phone ? -20 : -40).isActive = true
        buttonTest.leftAnchor.constraint(equalTo: viewMain.leftAnchor, constant: device == .phone ? 20 : 40).isActive = true
        buttonTest.widthAnchor.constraint(equalToConstant: device == .phone ? 270 : 520).isActive = true
        buttonTest.heightAnchor.constraint(equalToConstant: device == .phone ? 50 : 100).isActive = true
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
