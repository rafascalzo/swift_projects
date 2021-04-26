//
//  MarsTrekPresenter.swift
//  Spacing
//
//  Created by rvsm on 06/06/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import Foundation

class MarsTrekPresenter: MarsTrekPresenterProtocol {
    
    weak var view: MarsTrekViewProtocol?
    
    var interactor: MarsTrekInputInteractorProtocol?
    
    var wireframe: MarsTrekWireframeProtocol?
    
    func viewDidLoad() {
        view?.render()
        interactor?.fetch(mosaic: .EXPERIENCE_CURIOSITY_LANDING_SITE, row: 0, column: 0, zoomLevel: 0)
    }
}

extension MarsTrekPresenter: MarsTrekOutputInteractorProtocol {
    
    func show(error: String) {
        view?.show(error: error)
    }
}
