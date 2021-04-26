//
//  ViewController.swift
//  Cep
//
//  Created by rafaeldelegate on 6/22/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit
import MBProgressHUD
class CepViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navigation = navigationController{
            navigation.navigationBar.barStyle = .black
            navigation.navigationBar.isTranslucent = false
            navigation.isNavigationBarHidden = true
        }
        
        
        searchBarCity.delegate = self
        searchBarCity.returnKeyType = .done
        searchBarUF.delegate = self
        searchBarUF.returnKeyType = .done
        tableViewCity.delegate = self
        tableViewCity.dataSource = self
        tableViewUF.delegate = self
        tableViewUF.dataSource = self
        setupView()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    var isSearchingCity = false
    var isSearchingUF = false
    
    let cellId = "cellId"
    let ufCellId = "ufCellId"
    let citiesArray = ["São Paulo","Paraná","Santa Catarina", "Bahia","Acre","Mato Grosso", "Minas Gerais"]
    let ufArray = ["SP","MG","BA","SC","RJ","MT","AC"]
    
    var filteredCitiesArray = [String]()
    var filteredUfArray = [String]()
    
    let tableViewCity = CitiesTableView()
    let tableViewUF = UFTableView()
    let viewMain = ViewMain()
    let viewHeader = HeaderView()
    let viewBody = BodyView()
    let viewFooter = FooterView()
    let imageViewBrasi = LogoImageView(frame: CGRect.init())
    let searchBarCity = CitySearchBar()
    let labelTitle = TitleLabel()
    let textFieldAdress = AdressTextField()
    let searchBarUF = UFSearchBar()
    
    let buttonFindCep = ButtonFindCep()
    
    let labelCep = LabelCep()
    let textFieldCep = TextFieldCep()
    let labelStreet = LabelStreet()
    let textFieldStreet = TextFieldStreet()
    let labelCity = LabelCity()
    let textFieldCity = TextFieldCity()
    let labelDistrict = LabelDistrict()
    let textFieldDistrict = TextFieldDistrict()
    let labelState = LabelState()
    let textFieldState = TextFieldState()
    let labelIBGE = LabelIBGE()
    let textFieldIBGE = TextFieldIBGE()
    
    let stackViewBody = StackViewBody()

    var cep:String = ""
    
    @objc func findCep(_ sender: UIButton){
        
        let urlPath = "http://viacep.com.br/ws/"+textFieldCep.text!+"/json/"
        
        self.textFieldCity.text = ""
        self.textFieldIBGE.text = ""
        self.textFieldStreet.text = ""
        self.textFieldDistrict.text = ""
        self.textFieldState.text = ""
        
        self.showLoadingHUD()
         
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            
            ZipCodeAPI().retrieveZipCode(urlPath) { (zipCodeInfo) in
                
                guard let response:[String:String] = zipCodeInfo ,
                    let cep = response["cep"] as? String,
                    let street = response["logradouro"] as? String,
                    let state = response["uf"] as? String,
                    let city = response["localidade"] as? String,
                    let ibge = response["ibge"] as? String,
                    let district = response["bairro"] as? String else {
                        print("Malformed data received from fetchAllRooms service")
                        return}
                
                self.textFieldCep.text = cep
                self.textFieldCity.text = city
                self.textFieldIBGE.text = ibge
                self.textFieldStreet.text = street
                self.textFieldDistrict.text = district
                self.textFieldState.text = state
                self.hideLoadingHUD()
                
            }
        }
    }
    
    fileprivate func setupView(){
        
        view.backgroundColor = .black
        view.addSubview(viewMain)
        viewMain.addSubview(viewHeader)
        viewHeader.addSubview(labelTitle)
        viewMain.addSubview(viewBody)
        viewBody.addSubview(imageViewBrasi)
        viewBody.addSubview(stackViewBody)
        stackViewBody.addArrangedSubview(labelCep)
        stackViewBody.addArrangedSubview(textFieldCep)
        stackViewBody.addArrangedSubview(labelStreet)
        stackViewBody.addArrangedSubview(textFieldStreet)
        stackViewBody.addArrangedSubview(labelCity)
        stackViewBody.addArrangedSubview(textFieldCity)
        stackViewBody.addArrangedSubview(labelDistrict)
        stackViewBody.addArrangedSubview(textFieldDistrict)
        stackViewBody.addArrangedSubview(labelState)
        stackViewBody.addArrangedSubview(textFieldState)
        stackViewBody.addArrangedSubview(labelIBGE)
        stackViewBody.addArrangedSubview(textFieldIBGE)
        viewMain.addSubview(viewFooter)
        viewFooter.addSubview(buttonFindCep)
        viewMain.backgroundColor = .white
        
        viewMain.setupConstraints(topParent: self.view, bottomParent: self.view, leftParent: self.view, rightParent: self.view)
        
        viewHeader.topAnchor.constraint(equalTo: viewMain.topAnchor).isActive = true
        viewHeader.widthAnchor.constraint(equalTo: viewMain.widthAnchor).isActive = true
        viewHeader.heightAnchor.constraint(equalToConstant: 65).isActive = true
        
        labelTitle.centerXAnchor.constraint(equalTo: viewHeader.centerXAnchor).isActive=true
        labelTitle.centerYAnchor.constraint(equalTo: viewHeader.centerYAnchor).isActive = true
        labelTitle.widthAnchor.constraint(equalToConstant: 170).isActive = true
        labelTitle.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        viewBody.topAnchor.constraint(equalTo: viewHeader.bottomAnchor).isActive = true
        viewBody.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        viewBody.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        viewBody.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        viewBody.bottomAnchor.constraint(equalTo: viewFooter.topAnchor).isActive = true
        
        imageViewBrasi.centerXAnchor.constraint(equalTo: viewBody.centerXAnchor).isActive = true
        imageViewBrasi.centerYAnchor.constraint(equalTo: viewBody.centerYAnchor).isActive = true
        imageViewBrasi.widthAnchor.constraint(equalTo: viewBody.widthAnchor, constant: -40).isActive = true
        imageViewBrasi.heightAnchor.constraint(equalToConstant: 375).isActive = true
        
        stackViewBody.topAnchor.constraint(equalTo: viewBody.topAnchor, constant: 70).isActive = true
        stackViewBody.rightAnchor.constraint(equalTo: viewBody.rightAnchor, constant: -35).isActive = true
        stackViewBody.leftAnchor.constraint(equalTo: viewBody.leftAnchor, constant: 35).isActive = true
        
        labelCep.widthAnchor.constraint(equalTo: stackViewBody.widthAnchor).isActive=true
        labelCep.heightAnchor.constraint(equalToConstant: 28).isActive = true
        textFieldCep.widthAnchor.constraint(equalTo: stackViewBody.widthAnchor).isActive = true
        textFieldCep.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        labelStreet.widthAnchor.constraint(equalTo: stackViewBody.widthAnchor).isActive=true
        labelStreet.heightAnchor.constraint(equalToConstant: 28).isActive = true
        textFieldStreet.widthAnchor.constraint(equalTo: stackViewBody.widthAnchor).isActive = true
        textFieldStreet.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        labelCity.widthAnchor.constraint(equalTo: stackViewBody.widthAnchor).isActive=true
        labelCity.heightAnchor.constraint(equalToConstant: 28).isActive = true
        textFieldCity.widthAnchor.constraint(equalTo: stackViewBody.widthAnchor).isActive = true
        textFieldCity.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        labelDistrict.widthAnchor.constraint(equalTo: stackViewBody.widthAnchor).isActive=true
        labelDistrict.heightAnchor.constraint(equalToConstant: 28).isActive = true
        textFieldDistrict.widthAnchor.constraint(equalTo: stackViewBody.widthAnchor).isActive = true
        textFieldDistrict.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        labelState.widthAnchor.constraint(equalTo: stackViewBody.widthAnchor).isActive=true
        labelState.heightAnchor.constraint(equalToConstant: 28).isActive = true
        textFieldState.widthAnchor.constraint(equalTo: stackViewBody.widthAnchor).isActive = true
        textFieldState.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        labelIBGE.widthAnchor.constraint(equalTo: stackViewBody.widthAnchor).isActive=true
        labelIBGE.heightAnchor.constraint(equalToConstant: 28).isActive = true
        textFieldIBGE.widthAnchor.constraint(equalTo: stackViewBody.widthAnchor).isActive = true
        textFieldIBGE.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        viewFooter.setupConstraintLayout(parentBot: view, parentWidth: view, parentTop: viewBody, height: 76)
        
        NSLayoutConstraint.activate([
            buttonFindCep.centerXAnchor.constraint(equalTo: viewFooter.centerXAnchor),
            buttonFindCep.widthAnchor.constraint(equalTo: viewBody.widthAnchor, constant: -40),
            buttonFindCep.heightAnchor.constraint(equalToConstant: 66),
            buttonFindCep.centerYAnchor.constraint(equalTo: viewFooter.centerYAnchor)
            ])
        
    }
    
}

extension CepViewController {
    
    private func showLoadingHUD() {
        
        let hud = MBProgressHUD.showAdded(to: self.viewBody, animated: true)
        hud.label.text = "Loading..."
    }
    
    private func hideLoadingHUD() {
        MBProgressHUD.hide(for: self.viewBody, animated: true)
    }
}



