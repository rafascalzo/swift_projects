//
//  SpaceMainPresenter.swift
//  YSpace
//
//  Created by RVSM on 31/01/20.
//  Copyright © 2020 RVSM. All rights reserved.
//

import UIKit

class SpaceMainPresenter: SpaceMainPresenterProtocol {
    
    weak var view: SpaceMainViewProtocol?
    
    var interactor: SpaceMainInputInteractorProtocol?
    
    var wireframe: SpaceMainWireframeProtocol?
    
    func viewDidLoad() {
        view?.render()
    }
    
    func goTo(scene: Scene, from controller: UIViewController) {
        wireframe?.goTo(scene: scene, from: controller)
    }
}

extension SpaceMainPresenter: SpaceMainOutputInteractorProtocol {
    
}
