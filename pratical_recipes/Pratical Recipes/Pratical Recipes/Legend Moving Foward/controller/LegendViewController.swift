//
//  LegendViewController.swift
//  Pratical Recipes
//
//  Created by rafaeldelegate on 6/30/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

class LegendViewController: UIViewController {
    
    let apresentation = ApresentationLabel()
    var displayLink : CADisplayLink?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let navigation = navigationController{
            navigation.isNavigationBarHidden = true
        }
        
        setupLayout()
        
    }
    
    private func setupLayout(){
        apresentation.frame = self.view.frame
        view.backgroundColor = .red
        view.addSubview(apresentation)
        view.addSubview(buttonShowSecrets)
        buttonShowSecrets.setupConstraints(bottomParent: self.view, centerXParent: self.view)
        
    
    }
    
    let buttonShowSecrets = ButtonShowMeYourSecrets()
    
    @objc func showSecrets(_ sender: UIButton){
        endValue = apresentation.textLabel.count as? Double
        displayLink = CADisplayLink(target: self, selector: #selector(countHistory))
        displayLink?.add(to: .main, forMode: .default)
        currentCharPosition = 0
        countHistory()
    }
    
    let startValue:Double = 0
    var endValue:Double?
    var currentCharPosition:Int = 0
    var currentText = ""
    @objc func countHistory(){
        
        if currentCharPosition < apresentation.textLabel.count{
            let index = apresentation.textLabel.index(apresentation.textLabel.startIndex, offsetBy: currentCharPosition)
            currentText += String(apresentation.textLabel[index])
            self.apresentation.text = "\(currentText)"
            currentCharPosition+=1
        } else {
            displayLink?.isPaused.toggle()
            currentText = ""
        }
        
    }
}
