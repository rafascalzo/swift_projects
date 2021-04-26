//
//  ImageAndVideoLibraryPresenter.swift
//  YSpace
//
//  Created by RVSM on 29/03/20.
//  Copyright © 2020 RVSM. All rights reserved.
//

import Foundation

class ImageAndVideoLibraryPresenter: ImageAndVideoLibraryPresenterProtocol {
    
    weak var view: ImageAndViewLibraryViewProtocol?
    var interactor: ImageAndVideoLibraryInputInteractorProtocol?
    var wireframe: ImageAndVideLibraryWireframeProtocol?
    
    func viewDidLoad() {
        view?.render()
    }
}

extension ImageAndVideoLibraryPresenter: ImageAndVideoLibraryOutputInteractorProtocol {
    
}
