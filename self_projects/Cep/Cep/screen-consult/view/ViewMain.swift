//
//  ViewMain.swift
//  Cep
//
//  Created by rafael-estagio on 27/06/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

class ViewMain: UIView {

    let viewBackgroundColor = "#4a60e2"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setAutoLayoutView(viewBackgroundColor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints(topParent : UIView = UIView(), bottomParent : UIView = UIView(), leftParent : UIView = UIView(), rightParent : UIView = UIView()){
        NSLayoutConstraint.activate([self.topAnchor.constraint(equalTo: topParent.safeAreaLayoutGuide.topAnchor),
                                     self.bottomAnchor.constraint(equalTo: bottomParent.bottomAnchor),
                                     self.leftAnchor.constraint(equalTo: leftParent.leftAnchor),
                                     self.rightAnchor.constraint(equalTo: rightParent.rightAnchor)])
    }
    
}
