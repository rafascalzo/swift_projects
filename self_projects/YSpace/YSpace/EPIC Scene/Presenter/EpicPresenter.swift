//
//  EpicPresenter.swift
//  YSpace
//
//  Created by RVSM on 29/03/20.
//  Copyright © 2020 RVSM. All rights reserved.
//

import Foundation
class EpicPresenter: EpicPresenterProtocol {
    
    weak var view: EpicViewProtocol?
    var interactor: EpicInputInteractorProtocol?
    var wireframe: EpicWireframeProtocol?
    
    func viewDidLoad() {
        view?.render()
    }
}

extension EpicPresenter: EpicOutputInteractorProtocol {
    
}

