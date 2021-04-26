//
//  ViewController.swift
//  Cosmo City
//
//  Created by rafaeldelegate on 6/30/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit
import YoutubePlayer_in_WKWebView
import Lottie
import CoreData
class PictureOfTheDayViewController: UIViewController{
    
    var mediaList:Array<Media> = []
    var viewMedia = ViewMedia()
    var labelMainTitle = LabelPictureOfTheDay()
    var labelDate = LabelDate()
    var labelTitle = LabelTitle()
    var labelExplanation = LabelExplanation()
    var imageViewPictureOfTheDay = ImagePictureOfTheDay(frame: CGRect.init())
    let scrollViewExplanation = ScrollViewExplanation()
    let loadAnimation = LoadingAnimatedView()
    let webConfiguration = WKWebViewConfiguration()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.alpha = 0
        if let navigation = navigationController {
            navigation.isNavigationBarHidden = true
        }
        
        UIView.animate(withDuration: 2, delay: 0, options: .curveEaseInOut, animations: {
            self.view.alpha = 1
        }, completion: nil)
        
        setupView()
        loadAnimation.animatedLogo.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            
            self.requestImageOfTheDay()
        }
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    fileprivate func setupView(){
        
        _ = UIDevice.current.userInterfaceIdiom
        
        view.addSubview(loadAnimation)
        loadAnimation.center = self.view.center
    
        
        view.addSubview(labelMainTitle)
        labelMainTitle.setConstraints(topParent: self.view, xParent: self.view)
        view.addSubview(labelDate)
        labelDate.setConstraints(topParent: labelMainTitle, xParent: self.view)
        view.addSubview(labelTitle)
        labelTitle.setConstraints(topParent: labelDate, xParent: self.view)
        view.addSubview(viewMedia)
        viewMedia.setupConstraints(topParent: labelTitle, xParent: self.view)
        viewMedia.addSubview(imageViewPictureOfTheDay)
        imageViewPictureOfTheDay.setConstraints(topParent: self.viewMedia, xparent: self.viewMedia)
        view.addSubview(scrollViewExplanation)
        scrollViewExplanation.setConstraints(topParent: viewMedia, leftParent: self.view, rightParent: self.view, bottomParent: self.view)
        scrollViewExplanation.addSubview(labelExplanation)
        labelExplanation.setConstraints(topParent: scrollViewExplanation, xParent: self.view)
      
        view.backgroundColor = .backgroundColor
    }
    
    fileprivate func requestImageOfTheDay() {
        
        NASAApiClient().request { (dicionario) in
            let webView = WKWebView(frame: .zero, configuration: self.webConfiguration)
            webView.center = self.viewMedia.center
            
            self.mediaList = NASADAO().readMedia()
            let selectedMedia = self.mediaList.count - 1
            guard let explanation = self.mediaList[selectedMedia].explanation  else {return}
            guard let title = self.mediaList[selectedMedia].title else {return}
            guard let date = self.mediaList[selectedMedia].date else {return}
            guard let urlImage = self.mediaList[selectedMedia].url else {return}
            guard let mediaType = self.mediaList[selectedMedia].mediaType else {return}
            print(mediaType)
            
            if mediaType == "video"{
                self.view = webView
                guard let url = URL(string: urlImage) else {return}
                let urlRequest = URLRequest(url: url)
                webView.load(urlRequest)
                
            }else{
                let url = URL(string: urlImage)
                let data = try? Data(contentsOf: url!)
                self.imageViewPictureOfTheDay.image = UIImage(data: data!)
                self.viewMedia.setupImage(self.imageViewPictureOfTheDay)
                
            }
            self.labelTitle.text = title
            self.labelDate.text = date
            self.labelExplanation.text = explanation
            self.loadAnimation.removeFromSuperview()
        }
    }
}

