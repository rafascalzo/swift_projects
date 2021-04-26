//
//  ImageAndVideoLibraryPresenter.swift
//  Spacing
//
//  Created by rvsm on 11/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

class ImageAndVideoLibraryPresenter: ImageAndVideoLibraryPresenterProtocol {
    
    weak var view: ImageAndVideoLibraryViewProtocol?
    var interactor: ImageAndVideoLibraryInputInteractorProtocol?
    var wireframe: ImageAndVideLibraryWireframeProtocol?
    
    func viewDidLoad() {
        view?.render()
        interactor?.search()
    }
    
    func search(_ text: String?) {
        view?.showLoading()
        interactor?.search(text)
    }
}

extension ImageAndVideoLibraryPresenter: ImageAndVideoLibraryOutputInteractorProtocol {
    
    func show(error: String) {
        view?.removeLoading()
        view?.show(error: error.localized)
    }
    
    func didFetch(data: ImageVideLibraryDataWrapper) {
        view?.removeLoading()
        view?.didFetch(data: data)
    }
    
    
}
