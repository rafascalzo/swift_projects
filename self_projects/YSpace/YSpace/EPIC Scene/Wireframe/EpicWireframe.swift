//
//  EpicWireframe.swift
//  YSpace
//
//  Created by RVSM on 29/03/20.
//  Copyright © 2020 RVSM. All rights reserved.
//

import Foundation

class EpicWireframe: EpicWireframeProtocol {
    
    static func createModule(viewRef: EpicView) {
        let presenter: EpicPresenterProtocol & EpicOutputInteractorProtocol = EpicPresenter()
        viewRef.presenter = presenter
        viewRef.presenter?.view = viewRef
        viewRef.presenter?.interactor = EpicInputInteractor()
        viewRef.presenter?.wireframe = EpicWireframe()
    }
}
