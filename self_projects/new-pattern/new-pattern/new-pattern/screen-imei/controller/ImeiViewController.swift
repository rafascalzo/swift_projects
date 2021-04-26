//
//  ImeiViewController.swift
//  new-pattern
//
//  Created by Rafael on 6/7/19.
//  Copyright © 2019 Rafael. All rights reserved.
//

import UIKit

class ImeiViewController: UIViewController{
    
    let color = ColorConversor().hexStringToUIColor(hex: "#0ff")

    let labelImeiAdvice: UILabel = {
    let lb = UILabel()
        lb.textColor = .white
        lb.textAlignment = NSTextAlignment.center
        lb.text = "Para realizar o seu cadastro é preciso gerar um IMEI e cadastrar no seu perfil web"
        lb.numberOfLines = 3
       // lb.adjustsFontSizeToFitWidth = true
        lb.font = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? lb.font.withSize(18) : lb.font.withSize(56)
        
        return lb
    }()
    
    let labelConfirmImeiAdvice: UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.textAlignment = NSTextAlignment.center
        lb.text = "Já inseriu o código na web, clique em prosseguir para validar"
        lb.numberOfLines = 3
        lb.sizeThatFits(CGSize(width: 270, height: 66))
        lb.font = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? lb.font.withSize(18) : lb.font.withSize(56)
        
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let imageHeader : UIImageView = {
        let img = UIImageView()
        img.sizeThatFits(CGSize(width: 123, height: 103))
        img.backgroundColor = .purple
        
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    //IBAction func buttonFinalizarCompra(_ sender: UIButton)
    
 
        
        let buttonGenerateImei : UIButton = {
        let btn = UIButton.init()
       
        btn.setTitle("GERAR IMEI AGORA", for: .normal)
        btn.sizeThatFits(CGSize(width: 270, height: 5))
        btn.layer.cornerRadius = 15
        btn.backgroundColor = .blue
        btn.addTarget(self, action: #selector(generateImei(sender:)), for: .touchUpInside)
    
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    

    
    @objc func generateImei(sender: UIButton){
        print("oiee")
    }
    var buttonConfirmAndContinue : UIButton = {
        let btn = UIButton()
        btn.setTitle("VERIFICAR E CONTINUAR", for: .normal)
        btn.sizeThatFits(CGSize(width: 270, height: 5))
        btn.layer.cornerRadius = 15
        btn.backgroundColor = .blue
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let imeiViewOther = MainViews()
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageHeader,labelImeiAdvice,buttonGenerateImei,labelConfirmImeiAdvice, buttonConfirmAndContinue])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        //stackView.contentMode = .scaleToFill
        stackView.contentMode = .center
        stackView.alignment = UIStackView.Alignment.fill
        stackView.isLayoutMarginsRelativeArrangement = true
        
      
        return stackView
    }()
    
   
    
    fileprivate func setupView(){
        
       imeiViewOther.backgroundColor = .red
        view.backgroundColor = .red
        
        // MARK: StackView
        view.addSubview(mainStackView)
        mainStackView.backgroundColor = .orange
        NSLayoutConstraint.activate([
        mainStackView.topAnchor.constraint(equalTo: view.topAnchor),
        mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        mainStackView.leftAnchor.constraint(equalTo: view.leftAnchor),
        mainStackView.rightAnchor.constraint(equalTo: view.rightAnchor),
       mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ,mainStackView.heightAnchor.constraint(equalToConstant: view.frame.height/1)])
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
      
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
