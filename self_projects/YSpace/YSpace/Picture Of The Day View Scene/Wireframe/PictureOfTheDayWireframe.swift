//
//  PictureOfTheDayWireframe.swift
//  YSpace
//
//  Created by RVSM on 23/03/20.
//  Copyright © 2020 Rafael Scalzo. All rights reserved.
//

import Foundation

class PictureOfTheDayWireframe: PictureOfTheDayWireframeProtocol {
    
    static func createModule(viewRef: PictureOfTheDayView) {
        let presenter: PictureOfTheDayPresenterProtocol & PictureOfTheDayOutputInteractorProtocol = PictureOfTheDayPresenter()
        viewRef.presenter = presenter
        viewRef.presenter?.interactor = PictureOfTheDayInputInteractor()
        viewRef.presenter?.view = viewRef
        viewRef.presenter?.wireframe = PictureOfTheDayWireframe()
        viewRef.presenter?.interactor?.output = presenter
    }
    
    deinit {
        print("PictureOfTheDayWireframe has removed")
    }
}
