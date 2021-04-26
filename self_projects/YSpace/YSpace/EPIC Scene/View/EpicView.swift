//
//  EpicView.swift
//  YSpace
//
//  Created by RVSM on 29/03/20.
//  Copyright © 2020 RVSM. All rights reserved.
//

import UIKit

class EpicView: UIViewController, EpicViewProtocol {
    
    var presenter: EpicPresenterProtocol?
    
    func render() {
        view.backgroundColor = .systemRed
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EpicWireframe.createModule(viewRef: self)
        presenter?.viewDidLoad()
    }
}
