//
//  CitiesTableView.swift
//  Cep
//
//  Created by rafaeldelegate on 6/23/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

class CitiesTableView: UITableView {
    
    let cellId = "cellId"
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.alpha = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
