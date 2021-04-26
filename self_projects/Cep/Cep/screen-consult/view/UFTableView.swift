//
//  UFTableView.swift
//  Cep
//
//  Created by rafaeldelegate on 6/23/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

class UFTableView: UITableView {

    let ufCellId = "ufCellId"
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.register(UITableViewCell.self, forCellReuseIdentifier: ufCellId)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.alpha = 0
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(maoe(recognizer:)))
            self.addGestureRecognizer(recognizer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func maoe(recognizer: UITapGestureRecognizer){
        self.alpha = 0
    }

}
