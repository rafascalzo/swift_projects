//
//  DiscoveryViewController.swift
//  Marvel
//
//  Created by rafael-estagio on 19/07/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit
import Lottie
class DiscoveryViewController: UIViewController, HasCustomView, DiscoveryViewDelegate{
    
    typealias CustomView = ViewDiscovery
    
    var viewDiscovery: CustomView {
        
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
    
    var allCharacters : Array<CharacterDataWrapper.CharacterDataContainer.Character> = []
    var characters : Array<CharacterDataWrapper.CharacterDataContainer.Character> = []
    var requestOffset:Int = 0
    var requestLimit:Int = 30
    var selectedName:String = ""
    var selectedItem:[CharacterDataWrapper.CharacterDataContainer.Character]? = nil
    var selectedIndex:Int? = nil
    var score:Int = 0;
    var chances:Int = 2
    var indicator : ActivityIndicatorView?
    
    override func loadView() {
        let customView = CustomView()
        customView.delegate = self
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator = ActivityIndicatorView(controller: self)
        reloadGame()
    }
    
    func setupNavigation() {
        if let navigation = navigationController {
            navigation.isNavigationBarHidden = true
        }
    }
    
    func showTipsOptionsView(){
        viewDiscovery.showTipOptionbuttons()
    }
    
    fileprivate func checkData(_ data:CharacterDataWrapper){
        self.allCharacters = data.data?.results ?? []
        self.characters = []
        
        for i in 0...self.requestLimit - 1 {
            
            if characters.count == 5 {
                self.viewDiscovery.reloadAnswerButtons(chars: characters)
                return
            }
            if self.allCharacters[i].thumbnail?.path != "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available" && self.allCharacters[i].thumbnail?.extension != "gif"{
                self.characters.append(self.allCharacters[i])
            }
        }
        
        if characters.count < 5 {
            self.reloadGame()
        }
    }
    
    func handleTapPress(_ sender : Any){
        let button = sender as! UIButton
        self.selectedName = button.title(for: .normal)!
        print(button.tag)
        
        if self.chances == 0 {
            if button.tag == self.selectedIndex! {
                button.backgroundColor = .green
            } else {
                button.backgroundColor = .red
            }
            showAnswer()
            self.viewDiscovery.isUserInteractionEnabled = false
        }else if button.tag == self.selectedIndex!{
            button.backgroundColor = .green
            self.selectedName = button.title(for: .normal)!
            showAnswer()
            self.viewDiscovery.isUserInteractionEnabled = false
        } else{
            self.viewDiscovery.playWrongAnimation()
            self.viewDiscovery.isUserInteractionEnabled = false
            button.isUserInteractionEnabled = false
            button.backgroundColor = .red
            self.viewDiscovery.layoutIfNeeded()
            self.chances = chances - 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                self.viewDiscovery.isUserInteractionEnabled  = true
            }
        }
    }
    
    fileprivate func reloadGame() {
        self.viewDiscovery.layoutIfNeeded()
        self.getChars {
            self.viewDiscovery.setupDataView(self.getRandomListCharacter())
            self.viewDiscovery.reloadAnswerButtons(chars: self.characters)
            self.viewDiscovery.layoutIfNeeded()
        }
    }
    
    @objc func dismissTipsOptions(recognizer : UITapGestureRecognizer){
        self.viewDiscovery.removeTipsView()
        self.viewDiscovery.dismissOptionsTipsContainerView()
    }
    
    func showTips(_ sender: Any){
        
        let test = sender as! UIButton
        print(test.tag)
        if test.tag == 0 {
            self.viewDiscovery.dismissOptionsTipsContainerView()
            self.viewDiscovery.showComicsTips(comics: characters[selectedIndex!].comics!.items!)
        } else if test.tag == 1 {
            self.viewDiscovery.dismissOptionsTipsContainerView()
            self.viewDiscovery.showSeriesTips(self.characters[self.selectedIndex!].series!.items!)
        } else if test.tag == 2 {
            self.viewDiscovery.dismissOptionsTipsContainerView()
            self.viewDiscovery.showEventTips(events: characters[selectedIndex!].events!.items!)
        }
    }
    
    func backtoHome() {
        if let navigation = navigationController {
            navigation.popViewController(animated: true)
        }
    }
    
    fileprivate func getChars(completion: @escaping () -> Void) {
        
        requestOffset = Int.random(in: 0...1400)
        print(requestOffset)
        let orderBy = "-modified"
        self.indicator?.showHUD()
        self.viewDiscovery.isUserInteractionEnabled = false
        MarvelApi().getCharacteres(offset: requestOffset, limit: requestLimit, orderBy) { (success, characters) in
            if success{
                print(success)
                guard let chars = characters else {print("no readable data");return}
                self.checkData(chars)
                completion()
            }else{
                let alert = Alert(controller: self)
                let localizedStringSorry = NSLocalizedString("Sorry", comment: "")
                let localizedStringMessage = NSLocalizedString("Sorry", comment: "")
                
                alert.show(localizedStringSorry, message: localizedStringMessage, completion: {
                    //??
                })
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    func getRandomListCharacter() ->CharacterDataWrapper.CharacterDataContainer.Character{
        //print(characters.count)
        self.selectedIndex = Int.random(in: 0..<5)
        //print(selectedIndex)
        self.indicator?.dismissHUD()
        self.viewDiscovery.isUserInteractionEnabled = true
        return (characters[selectedIndex!])
    }
    
    func showAnswer() {
        
        self.score = self.viewDiscovery.showAnswer(selectedName, selectedIndex: selectedIndex!, characters: characters, currentScore: score)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.chances = 2
            self.reloadGame()
            self.viewDiscovery.layoutIfNeeded()
        }
    }
}

