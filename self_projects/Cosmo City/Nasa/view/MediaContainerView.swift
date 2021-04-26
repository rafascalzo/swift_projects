//
//  MediaContainerView.swift
//  Cosmo City
//
//  Created by rafaeldelegate on 7/7/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit
import YoutubePlayer_in_WKWebView

class MediaContainerView: UIView {
    
    struct Constants {
        
        static let device = UIDevice.current.userInterfaceIdiom
        static let padding:CGFloat =  Constants.device == .phone ? 16 : 64
        static let paddingTop:CGFloat = Constants.device == .phone ? 7 : 14
        static let height:CGFloat = Constants.device == .phone ? 250 : 500
    }
    
    let webConfiguration = WKWebViewConfiguration()
    
    var image = UIImageView()
    var date = UILabel()
    var view = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBasicView(UIColor.clear)
      }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupAnchor(top:UILabel, view:UIView){
        
        let guide = view.safeAreaLayoutGuide
        let estimatedSize = view.frame.width - (2 * Constants.padding)
        
        anchor(top: top.bottomAnchor, leading: guide.leadingAnchor, trailing: guide.trailingAnchor, bottom: nil, padding: .init(top: Constants.paddingTop, left: Constants.padding, bottom: 0, right: -Constants.padding), size: .init(width: estimatedSize, height: Constants.height))
        
    }
    
    func setupImage(_ date:String, _ url:String){
        
        let url = URL(string: url)
        let data = try? Data(contentsOf: url!)
        self.image.image = UIImage(data: data!)
        
        self.date.setupBasicLabel(date, UIFont.fontForMediaDate)
        self.date.textColor = .white
        addSubview(self.image)
        
        self.image.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: nil, padding: .init(top: 0, left: 0, bottom: -Constants.padding, right: 0))
        self.image.anchorSize(to: self)
        
        addSubview(self.view)
        
        self.view.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: nil, padding: .init(top: 0, left: 0, bottom: -Constants.padding, right: 0))
        self.view.anchorSize(to: self)
        view.backgroundColor = .clear
        
        self.image.addSubview(self.date)
        
        self.date.anchor(top: self.image.topAnchor, leading: nil, trailing: self.image.trailingAnchor, bottom: nil)
    }
    
    func setVideo(_ urlPath:String){
        
        
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        
        webView.center = center
        
        let url = URL(string: urlPath)
        let urlRequest = URLRequest(url: url!)
        webView.load(urlRequest)
        self.view = webView
        
        
        
       
        
    }
}
