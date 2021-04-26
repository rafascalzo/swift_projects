//
//  PictureOfTheDayPresenter.swift
//  YSpace
//
//  Created by RVSM on 23/03/20.
//  Copyright © 2020 Rafael Scalzo. All rights reserved.
//

import Foundation

class PictureOfTheDayPresenter: PictureOfTheDayPresenterProtocol {
    
    func fetchImageBy(date: Date, hd: Bool) {
        view?.showLoading()
        interactor?.fetchImageBy(date: date, hd: hd)
    }
    
    weak var view: PictureOfTheDayViewProtocol?
    
    var interactor: PictureOfTheDayInputInteractorProtocol?
    
    var wireframe: PictureOfTheDayWireframeProtocol?
    
    func viewDidLoad() {
        view?.showLoading()
        view?.render()
        interactor?.fetchContent()
    }
}

extension PictureOfTheDayPresenter: PictureOfTheDayOutputInteractorProtocol {
    
    func didReceived(content: PictureOfTheDay) {
        view?.removeLoading()
        view?.load(content)
    }
    
    func showError(_ message: String) {
        view?.removeLoading()
        view?.showError(message)
    }
}
