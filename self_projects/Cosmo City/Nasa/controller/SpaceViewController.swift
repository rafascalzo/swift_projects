//
//  SpaceViewController.swift
//  Cosmo City
//
//  Created by rafaeldelegate on 7/6/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit
import YoutubePlayer_in_WKWebView
import Lottie
class SpaceViewController: UIViewController {
    
    var mediaList:Array<Media> = []
    var titleLabel = TitleLabel()
    var mediaNameLabel = MediaName()
    var mediaContainerView = MediaContainerView()
    var explanationView = ExplanationView()
    let loadAnimation = LoadingAnimationView()
    let webConfiguration = WKWebViewConfiguration()
    let buttonCollection = ButtonCollection()
    
    
    fileprivate func setupNavigation() {
        if let navigation = navigationController {
            navigation.isNavigationBarHidden = true
        }
    }
    
    fileprivate func setupViewDidLoadAnimation() {
        view.alpha = 0
        UIView.animate(withDuration: 2, delay: 0, options: .curveEaseInOut, animations: {
            self.view.alpha = 1
        }, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupViewDidLoadAnimation()
        setupLayout()
        loadAnimation.animatedLogo.play()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            
            self.requestImageOfTheDay()
        }
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    fileprivate func setupLayout(){
        
        view.backgroundColor = .backgroundColor
        
        view.addSubview(buttonCollection)
        buttonCollection.setupAnchors(self.view)
        view.addSubview(loadAnimation)
        loadAnimation.center = self.view.center
        view.addSubview(titleLabel)
        titleLabel.setupAnchor(view: view)
        view.addSubview(mediaNameLabel)
        mediaNameLabel.setupAnchor(view: view, parent: titleLabel)
        view.addSubview(mediaContainerView)
        mediaContainerView.setupAnchor(top: mediaNameLabel, view: view)
        view.addSubview(explanationView)
        explanationView.setupAnchors(top: mediaContainerView, view: view)
        
    }
    
    fileprivate func requestImageOfTheDay() {
        
        NasaRepository().retrieveMedia { (mediaList) in
            
            self.mediaList = mediaList
            let selectedMedia = self.mediaList.count - 1
            
            guard let explanation = self.mediaList[selectedMedia].explanation  else {return}
            guard let mediaName = self.mediaList[selectedMedia].title else {return}
            guard let date = self.mediaList[selectedMedia].date else {return}
            guard let urlImage = self.mediaList[selectedMedia].url else {return}
            guard let mediaType = self.mediaList[selectedMedia].mediaType else {return}
            
            let webView = WKWebView(frame: .zero, configuration: self.webConfiguration)
            webView.center = self.mediaContainerView.center
            
            print(mediaType)
            if mediaType == "video"{
                self.view = webView
                guard let url = URL(string: urlImage) else {return}
                let urlRequest = URLRequest(url: url)
                webView.load(urlRequest)
//                self.mediaContainerView.setVideo(urlImage)
                
            }else{
                self.mediaContainerView.setupImage(date, urlImage)
            }
            
            self.mediaNameLabel.text = mediaName
            self.explanationView.setupTextView(text: explanation)
            self.loadAnimation.removeFromSuperview()
        }
    }
    
    @objc func goToCollection(_ sender:UIButton){
        if let navigation = navigationController {
            
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
                self.view.transform = CGAffineTransform(translationX: self.view.frame.width, y: 0)
            }) { (_) in
                navigation.pushViewController(PicturesViewController(), animated: true)
            }
        }
    }
    
    
}
