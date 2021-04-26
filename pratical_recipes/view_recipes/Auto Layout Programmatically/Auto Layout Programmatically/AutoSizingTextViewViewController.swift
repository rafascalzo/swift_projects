//
//  AutoSizingTextViewViewController.swift
//  Auto Layout Programmatically
//
//  Created by rafaeldelegate on 7/6/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

class AutoSizingTextViewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navigation = navigationController {
            navigation.isNavigationBarHidden = true
        }
        
        let textView = UITextView()
        
        textView.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        textView.backgroundColor = .gray
        textView.translatesAutoresizingMaskIntoConstraints
         = false
        textView.font = UIFont.preferredFont(forTextStyle: .headline)
        
        view.backgroundColor = .white
        view.addSubview(textView)
        
        [
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            textView.heightAnchor.constraint(equalToConstant: 50)
            
        ].forEach{$0.isActive = true}
        textView.text = "Here is some default text that we want to show and it might be a couple of lines that are the word wrapped"
        textView.delegate = self
        textView.isScrollEnabled = false
        textViewDidChange(textView)

       
    }

}

extension AutoSizingTextViewViewController : UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
       let estimatedSize = textView.sizeThatFits(size)
        
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
               constraint.constant = estimatedSize.height
            }
        }
    }
}
