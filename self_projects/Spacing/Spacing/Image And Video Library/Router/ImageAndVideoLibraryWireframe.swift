//
//  ImageAndVideoLibraryWireframe.swift
//  Spacing
//
//  Created by rvsm on 11/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import Foundation

class ImageAndVideoLibraryWireframe: ImageAndVideLibraryWireframeProtocol {
    
    weak var controller: ImageAndVideoLibraryView?
    
    static func createModule(viewRef: ImageAndVideoLibraryView) {
        let presenter: ImageAndVideoLibraryPresenterProtocol & ImageAndVideoLibraryOutputInteractorProtocol = ImageAndVideoLibraryPresenter()
        viewRef.presenter = presenter
        viewRef.presenter?.view = viewRef
        viewRef.presenter?.interactor = ImageAndVideoLibraryInputInteractor()
        viewRef.presenter?.interactor?.output = presenter
        viewRef.presenter?.wireframe = ImageAndVideoLibraryWireframe()
        viewRef.presenter?.wireframe?.controller = viewRef
    }
    
    deinit {
        NSLog("Image and video library controller has removed.")
    }
}
