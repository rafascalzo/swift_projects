//
//  ImageAndVideoLibraryWireframe.swift
//  YSpace
//
//  Created by RVSM on 29/03/20.
//  Copyright © 2020 RVSM. All rights reserved.
//

import Foundation

class ImageAndVideoLibraryWireframe: ImageAndVideLibraryWireframeProtocol {
    
    static func createModule(viewRef: ImageAndVideoLibraryView) {
        let presenter: ImageAndVideoLibraryPresenterProtocol & ImageAndVideoLibraryOutputInteractorProtocol = ImageAndVideoLibraryPresenter()
        viewRef.presenter = presenter
        viewRef.presenter?.view = viewRef
        viewRef.presenter?.interactor = ImageAndVideoLibraryInputInteractor()
        viewRef.presenter?.wireframe = ImageAndVideoLibraryWireframe()
    }
}
