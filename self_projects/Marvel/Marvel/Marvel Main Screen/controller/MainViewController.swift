//
//  TestViewController.swift
//  Marvel
//
//  Created by rafaeldelegate on 7/13/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit
import Lottie

class MainViewController: UIViewController, HasCustomView, ViewMainDelegate,UISearchBarDelegate{
    
    typealias CustomView = ViewMain
    
    var testView: CustomView {
        if let view = self.view as? CustomView {
            view.delegate = self
            return view
        } else {
            let view = CustomView()
            view.delegate = self
            self.view = view
            return view
        }
    }
    override func loadView() {
        let mainView = CustomView()
        mainView.delegate = self
        view = mainView
    }
    
    let appIconService = AppIconService()
    let customCellIdentifier = "cellIdentifier"
    var comics : Array<Thumbnails> = []
    var allComics : Array<Thumbnails> = []
    var allCharacters : Array<CharacterDataWrapper.CharacterDataContainer.Character> = []
    var characters : Array<CharacterDataWrapper.CharacterDataContainer.Character> = []
    var charactersFoundedByName : Array<CharacterDataWrapper.CharacterDataContainer.Character> = []
    var requestOffset:Int = 0
    var requestLimit:Int = 40
    var indicator : ActivityIndicatorView?
    let debouncer = Debouncer(timeInterval: 1)
    fileprivate func setupCollectionView() {
        testView.collectionViewCharacters.delegate = self
        testView.collectionViewCharacters.dataSource = self
    }
    func textDidChangeRenewInterval() {
        // When the user performs a repeating action, such as entering text, invoke the `renewInterval` method
        debouncer.renewInterval()
    }
    
    fileprivate func setupSearchBar() {
        testView.searchBar.delegate = self
    }
    
    override func viewDidLoad() {
        // loading
        indicator = ActivityIndicatorView(controller: self)
        indicator?.showHUD()
        
        // setup Icons
        appIconService.changeAppIcon(to: .primaryAppIcon)
        setupCollectionView()
        setupSearchBar()
        retrieveCharacteres()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func goToQuizGame(){
        if let navigation = navigationController {
            
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.testView.viewMenu.transform = CGAffineTransform.identity
                self.testView.viewMenu.alpha = 0.35
                self.testView.viewMenu.layer.shadowColor = UIColor.lightGray.cgColor
                self.testView.viewMenu.layer.borderColor = UIColor.lightGray.cgColor
                self.testView.bluredView.alpha = 0
                
            }) { (_) in
                self.testView.removeBackgroundBlur()
            }
            navigation.pushViewController(DiscoveryViewController(), animated: true)
        }
    }
    
    fileprivate func checkData(_ data:CharacterDataWrapper, completion: ()){
        
        self.allCharacters = data.data?.results ?? []
        for i in 0...self.requestLimit - 1 {
            
            if self.allCharacters[i].thumbnail?.path != "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available" && self.allCharacters[i].thumbnail?.extension != "gif"{
                self.characters.append(self.allCharacters[i])
            }
        }
        self.testView.collectionViewCharacters.reloadData()
    }
    fileprivate func checkDataFiltered(_ data:CharacterDataWrapper, completion: ()){
        self.characters = []
        self.charactersFoundedByName = data.data?.results ?? []
        if self.charactersFoundedByName.count > 0 {
            
            for i in 0...self.charactersFoundedByName.count - 1 {
                
                if self.charactersFoundedByName[i].thumbnail?.path != "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available" && self.charactersFoundedByName[i].thumbnail?.extension != "gif"{
                    self.characters.append(self.charactersFoundedByName[i])
                }
            }
            self.testView.collectionViewCharacters.reloadData()
        }
        self.testView.collectionViewCharacters.reloadData()
    }
    fileprivate func checkArray(array:Array<CharacterDataWrapper.CharacterDataContainer.Character>, completion: ()){
        characters = []
        
        for i in 0...self.allCharacters.count - 1{
            if self.allCharacters[i].thumbnail?.path != "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available" && self.allCharacters[i].thumbnail?.extension != "gif"{
                self.characters.append(self.allCharacters[i])
            }
        }
        self.testView.collectionViewCharacters.reloadData()
    }
    
    fileprivate func retrieveCharacteres(completion: @escaping () -> Void? = {}){
        testView.loadingAnimation.play()
        
        characters = []
        MarvelApi().getCharacteres(offset: requestOffset, limit: requestLimit) { (success, characters) in
            
            if success{
                guard let chars = characters else {print("no readable data");return}
                self.checkData(chars, completion:
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        self.testView.isUserInteractionEnabled = true
                        self.indicator?.dismissHUD()
                })
                completion()
            }else{
                self.testView.addnotFoundedAnimation()
                self.testView.notFoundedAnimation.play()
                let alert = Alert(controller: self)
                let localizedStringSorry = NSLocalizedString("Sorry", comment: "")
                let localizedMessage = NSLocalizedString("Our servers are temporarily unavailable", comment: "")
                alert.show(localizedStringSorry, message: localizedMessage, completion: {
                    
                    self.testView.notFoundedAnimation.removeFromSuperview()
                    //??
                })
                completion()
            }
        }
        self.testView.animationView.removeFromSuperview()
        self.testView.loadingAnimation.stop()
    }
    func tryAgain(){
        
        if let navigation = navigationController {
            navigation.pushViewController(InitialViewController(), animated: true)
            navigation.popViewController(animated: true)
        }
    }
    func handleSwipes(_ recognizer: UISwipeGestureRecognizer){
        
        let translationx:CGFloat = view.frame.width * 0.42
        
        if recognizer.direction == .right {
            self.testView.bringSubviewToFront(self.testView.viewMenu)
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.testView.viewMenu.transform = CGAffineTransform(translationX: translationx, y: 0)
                self.testView.viewMenu.alpha = 0.85
                self.testView.viewMenu.layer.shadowColor = UIColor.black.cgColor
                self.testView.viewMenu.layer.borderColor = UIColor.black.cgColor
                self.testView.addBackgroundBlur()
                self.testView.bluredView.alpha = 1
            })
        }
        
        if recognizer.direction == .left {
            
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.testView.viewMenu.transform = CGAffineTransform.identity
                self.testView.viewMenu.alpha = 0.35
                self.testView.viewMenu.layer.shadowColor = UIColor.lightGray.cgColor
                self.testView.viewMenu.layer.borderColor = UIColor.lightGray.cgColor
                self.testView.bluredView.alpha = 0
            }) { (_) in
                self.testView.removeBackgroundBlur()
            }
        }
    }
}

extension MainViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.testView.collectionViewCharacters.dequeueReusableCell(withReuseIdentifier: customCellIdentifier, for: indexPath) as! CollectionViewCellCharacters
        
        let selectedCell = self.characters[indexPath.row]
        cell.configureCell(selectedCell.name!, selectedCell.thumbnail!)
        
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        textDidChangeRenewInterval()
        
        debouncer.handler = {
            self.indicator?.showHUD()
            self.testView.isUserInteractionEnabled = false
            
            if searchText == ""{
                self.checkArray(array: self.allCharacters, completion:
                    DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                        self.testView.isUserInteractionEnabled = true
                        self.indicator?.dismissHUD()
                    })
                )
            }else{
                MarvelApi().retrieveCharacteresByName(searchText, limit: self.requestLimit, completion: { (sucess, chars) in
                    
                    if sucess {
                        guard let charsFiltered = chars else {return}
                        self.checkDataFiltered(charsFiltered, completion:
                            DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                                self.testView.isUserInteractionEnabled = true
                                self.indicator?.dismissHUD()
                            })
                        )
                    }else{
                        print("no tyenes nada manito")
                    }
                })
            }
            
            //            self.checkArray(array: self.allCharacters)
            //
            //            if searchText != "" {
            //                self.characters = self.characters.filter { $0.name!.contains(searchText) }
            //            }
            //            self.testView.collectionViewCharacters.reloadData()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height:CGFloat = self.view.frame.height * 0.22
        return UIDevice.current.userInterfaceIdiom == .phone ? CGSize(width: collectionView.bounds.width/2-10, height: height) : CGSize(width: collectionView.bounds.width/3-10, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = characters[indexPath.item]
        let controller = HeroDetailsViewController()
        controller.selectedItem = item
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == characters.count - 7{
            self.testView.isUserInteractionEnabled = false
            self.indicator?.showHUD()
            self.requestOffset = requestOffset + requestLimit
            
            MarvelApi().getCharacteres(offset: requestOffset, limit: requestLimit) { (success, characters) in
                
                if success{
                    guard let chars = characters else {print("no readable data");return}
                    self.checkData(chars, completion:
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.testView.isUserInteractionEnabled = true
                            self.indicator?.dismissHUD()
                    })
                }else{
                    let alert = Alert(controller: self)
                    let localizedStringSorry = NSLocalizedString("Sorry", comment: "")
                    
                    let localizedMessage = NSLocalizedString("Our servers are temporarily unavailable", comment: "")
                    alert.show(localizedStringSorry, message: localizedMessage, completion: {
                        //??
                    })
                }
            }
        }
    }
}
