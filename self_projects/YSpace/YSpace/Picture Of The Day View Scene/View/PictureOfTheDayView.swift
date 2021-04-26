//
//  PictureOfTheDayView.swift
//  YSpace
//
//  Created by RVSM on 22/03/20.
//  Copyright © 2020 Rafael Scalzo. All rights reserved.
//

import UIKit

enum MediaType: String {
    case image = "image", video = "video"
}

private let imageTitleHeight:CGFloat = 25
private let mediaContainerViewHeight: CGFloat = 250

private let datePickerContainerHeight: CGFloat = 250

import WebKit

class PictureOfTheDayView: UIViewController, PictureOfTheDayViewProtocol {
    
    func showLoading() {
        showActivityIndicator()
    }
    
    func removeLoading() {
        removeActivityIndicatorView()
    }
    var presenter: PictureOfTheDayPresenterProtocol?
    
    func showError(_ message: String) {
        let ac = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "ok".localized, style: .default, handler: nil))
        present(ac, animated: true)
    }
    
    func load(_ content: PictureOfTheDay) {
        print(content)
        imageTitle.text = content.title
        imageDescription.text = content.explanation
        if content.mediaType == MediaType.image.rawValue {
            configure(content: content,for: .image)
        } else {
            configure(content: content, for: .video)
        }
    }
    
    var datePickerContainerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        view.backgroundColor = .white
        return view
    }()
    
    lazy var datePickerToolbar: UIToolbar = {
        let toolbar = UIToolbar()
        let cancel = UIBarButtonItem(title: "cancel".localized, style: .plain, target: self, action: #selector(handleCancelToolbar))
        cancel.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.purple], for: .normal)
        let flexibleSpaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let ok = UIBarButtonItem(title: "ok".localized, style: .plain, target: self, action: #selector(handleOkToolbar))
        ok.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.purple], for: .normal)
        let itens = [cancel, flexibleSpaceButton, ok]
        toolbar.setItems(itens, animated: false)
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        return toolbar
    }()
    
    @objc func handleCancelToolbar() {
        hideDatePicker()
    }
    
    @objc func handleOkToolbar() {
        let date = datePicker.date
        presenter?.fetchImageBy(date: date, hd: true)
        hideDatePicker()
    }
    
    lazy var datePicker: UIDatePicker = {
       let pv = UIDatePicker()
        pv.datePickerMode = .date
        pv.translatesAutoresizingMaskIntoConstraints = false
        return pv
    }()
    
    var imageTitle: UILabel = {
       let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    var mediaContainerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var pictureImageView: UIImageView = {
       let iv = UIImageView(autoLayout: true)
        return iv
    }()
    
    var videoView: WKWebView = {
        let vv = WKWebView()
        return vv
    }()
    
    var imageDescription: UITextView = {
        let tv = UITextView(autoLayout: true)
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        PictureOfTheDayWireframe.createModule(viewRef: self)
        presenter?.viewDidLoad()
    }
    
    func render() {
        renderNavigationBar()
        
        view.addSubview(imageTitle)
        view.addSubview(mediaContainerView)
        view.addSubview(imageDescription)
        mediaContainerView.addSubview(pictureImageView)
        
        view.addSubview(datePickerContainerView)
        datePickerContainerView.addSubview(datePickerToolbar)
        datePickerContainerView.addSubview(datePicker)
        
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            imageTitle.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 35),
            imageTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageTitle.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            imageTitle.heightAnchor.constraint(equalToConstant: imageTitleHeight),
            
            mediaContainerView.topAnchor.constraint(equalTo: imageTitle.bottomAnchor, constant: 17),
            mediaContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            mediaContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            mediaContainerView.heightAnchor.constraint(equalToConstant: mediaContainerViewHeight),
            
            imageDescription.topAnchor.constraint(equalTo: mediaContainerView.bottomAnchor, constant: 17),
            imageDescription.leadingAnchor.constraint(equalTo: mediaContainerView.leadingAnchor),
            imageDescription.trailingAnchor.constraint(equalTo: mediaContainerView.trailingAnchor),
            imageDescription.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            
            datePickerContainerView.topAnchor.constraint(equalTo: view.bottomAnchor),
            datePickerContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            datePickerContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            datePickerContainerView.heightAnchor.constraint(equalToConstant: datePickerContainerHeight),
            
            datePickerToolbar.topAnchor.constraint(equalTo: datePickerContainerView.topAnchor),
            datePickerToolbar.leadingAnchor.constraint(equalTo: datePickerContainerView.leadingAnchor),
            datePickerToolbar.trailingAnchor.constraint(equalTo: datePickerContainerView.trailingAnchor),
            datePickerToolbar.heightAnchor.constraint(equalToConstant: 35),
            
            datePicker.topAnchor.constraint(equalTo: datePickerToolbar.bottomAnchor),
            datePicker.leadingAnchor.constraint(equalTo: datePickerContainerView.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: datePickerContainerView.trailingAnchor),
            datePicker.bottomAnchor.constraint(equalTo: datePickerContainerView.bottomAnchor)
        ])
        
        let views: [UIView] = [pictureImageView]
        for (index, view) in views.enumerated() {
            mediaContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v\(index)]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v\(index)":view]))
            
            mediaContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v\(index)]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v\(index)":view]))
        }
        
        showLoading()
    }
    
    func renderNavigationBar() {
        title = "picture_of_the_day".localized
        let rightBar = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleSearch))
        rightBar.tintColor = .purple
        navigationItem.rightBarButtonItem = rightBar
    }
    
    @objc func handleSearch() {
        showDatePicker()
    }
    
    func showDatePicker() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.datePickerContainerView.transform = CGAffineTransform(translationX: 0, y: -datePickerContainerHeight)
            self.datePickerContainerView.alpha = 1
        }) { finished in
            
        }
    }
    
    func hideDatePicker() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.datePickerContainerView.transform = CGAffineTransform.identity
            self.datePickerContainerView.alpha = 0
        }) { finished in
            
        }
    }
    func configure(content: PictureOfTheDay,for mediaType: MediaType) {
        switch mediaType {
        case .video:
            pictureImageView.alpha = 0
            videoView.alpha = 1
            
            videoView = WKWebView(frame: mediaContainerView.bounds, configuration: WKWebViewConfiguration())
            videoView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.mediaContainerView.addSubview(videoView)
            videoView.load(URLRequest(url: URL(string: content.urlString)!))
        default:
            videoView.alpha = 0
            pictureImageView.alpha = 1
            if let url = URL(string: content.urlString) {
                if let data = try? Data(contentsOf: url) {
                    let image = UIImage(data: data)
                    pictureImageView.image = image
                }
            }
            /*
             Load image on wkwebview
             videoView = WKWebView(frame: mediaContainerView.bounds, configuration: WKWebViewConfiguration())
             videoView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
             self.mediaContainerView.addSubview(videoView)
             videoView.load(URLRequest(url: URL(string: content.urlString)!))
             */
        }
    }
}
