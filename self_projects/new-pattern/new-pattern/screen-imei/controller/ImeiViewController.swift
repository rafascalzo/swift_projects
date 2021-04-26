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
        let size : CGSize =  {
            let siz = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? CGSize(width: 278, height: 66) : CGSize(width: 556, height: 132)
            return siz
        }()
        lb.sizeThatFits(size)
        lb.font = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? lb.font.withSize(18) : lb.font.withSize(36)
        
        return lb
    }()
    
    let labelConfirmImeiAdvice: UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.textAlignment = NSTextAlignment.center
        lb.text = "Já inseriu o código na web, clique em prosseguir para validar"
        lb.numberOfLines = 3
        let size : CGSize =  {
            let siz = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? CGSize(width: 278, height: 66) : CGSize(width: 556, height: 132)
            return siz
        }()
        lb.sizeThatFits(size)
        lb.font = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? lb.font.withSize(18) : lb.font.withSize(36)
        
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let imageHeader : UIImageView = {
        let img = UIImageView()
        
        let size : CGSize =  {
            let siz = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? CGSize(width: 123, height: 102) : CGSize(width: 246, height: 204)
            return siz
        }()
        
        img.sizeThatFits(size)
        img.backgroundColor = .purple
        
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    //IBAction func buttonFinalizarCompra(_ sender: UIButton)
    
 
        
        let buttonGenerateImei : UIButton = {
        let btn = UIButton.init()
        btn.setTitle("GERAR IMEI AGORA", for: .normal)
        btn.setTitleColor(ColorConversor().hexStringToUIColor(hex: "#CC0808"), for: UIControl.State.normal)
        let size : CGSize =  {
            let siz = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? CGSize(width: 292,height: 53) : CGSize(width: 584, height: 106)
            return siz
        }()
        btn.frame.size = size

        btn.layer.cornerRadius = 15
        btn.backgroundColor = .white
        btn.addTarget(self, action: #selector(generateImei(sender:)), for: .touchUpInside)
       
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    @objc func generateImei(sender: UIButton){
        print("vamo timeeee")
    }
    
    
    var buttonConfirmAndContinue : UIButton = {
        let btn = UIButton()
        
        btn.setTitle("VERIFICAR E CONTINUAR", for: .normal)
        btn.setTitleColor(ColorConversor().hexStringToUIColor(hex: "#CC0808"), for: UIControl.State.normal)
        btn.sizeThatFits(CGSize(width: 270, height: 5))
        btn.layer.cornerRadius = 15
        btn.backgroundColor = .white
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let imeiViewOther = MainViews()
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageHeader,labelImeiAdvice,buttonGenerateImei,labelConfirmImeiAdvice, buttonConfirmAndContinue])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = UIStackView.Distribution.equalCentering
        //stackView.contentMode = .scaleToFill
        stackView.contentMode = .center
        stackView.alignment = UIStackView.Alignment.center
        stackView.isLayoutMarginsRelativeArrangement = true
        
      
        return stackView
    }()
    
   
    
    fileprivate func setupView(){
        
       imeiViewOther.backgroundColor = .red
        view.backgroundColor = ColorConversor().hexStringToUIColor(hex: "#CC0808")
        
        // MARK: StackView
        view.addSubview(mainStackView)
        mainStackView.backgroundColor = .orange
        NSLayoutConstraint.activate([
        mainStackView.topAnchor.constraint(equalTo: view.topAnchor),
        mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        mainStackView.leftAnchor.constraint(equalTo: view.leftAnchor),
        mainStackView.rightAnchor.constraint(equalTo: view.rightAnchor)])
        
        imageHeader.widthAnchor.constraint(equalToConstant: 123).isActive = true
        imageHeader.heightAnchor.constraint(equalToConstant: 102).isActive = true
        
        buttonConfirmAndContinue.widthAnchor.constraint(equalToConstant: 270).isActive = true
        buttonConfirmAndContinue.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        buttonGenerateImei.widthAnchor.constraint(equalToConstant: 270).isActive = true
        buttonGenerateImei.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
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
