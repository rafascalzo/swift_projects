//
//  HeroDetaisViewController.swift
//  Marvel
//
//  Created by rafael-estagio on 12/07/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit
import SnapKit

class HeroDetailsViewController: UIViewController , HasCustomView, HeroDetailsViewDelegate{
    
    typealias CustomView = HeroDetailsView
    var testView: CustomView {
        
        if let view = self.view as? CustomView {
            view.delegate = self
            return view
        } else {
            let view = CustomView()
            view.delegate = self
            self.view = view
            return view
        }
    }
    var selectedItem:CharacterDataWrapper.CharacterDataContainer.Character? = nil
    override func loadView() {
        let customView = CustomView()
        customView.delegate = self
        view = customView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        testView.configView(selectedItem!)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    func backToPreviowsController(){
        if let navigation = navigationController {
            navigation.popViewController(animated: true)
        }
    }
}
