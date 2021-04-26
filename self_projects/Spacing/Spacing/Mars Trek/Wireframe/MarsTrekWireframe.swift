//
//  MarsTrekWireframe.swift
//  Spacing
//
//  Created by rvsm on 06/06/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import Foundation

class MarsTrekWireframe: MarsTrekWireframeProtocol {
    
    weak var controller: MarsTrekView?
    
    static func createModule(viewRef: MarsTrekView) {
        let presenter: MarsTrekPresenterProtocol & MarsTrekOutputInteractorProtocol = MarsTrekPresenter()
        viewRef.presenter = presenter
        viewRef.presenter?.view = viewRef
        viewRef.presenter?.interactor = MarsTrekInputInteractor()
        viewRef.presenter?.interactor?.output = presenter
        viewRef.presenter?.wireframe = MarsTrekWireframe()
        viewRef.presenter?.wireframe?.controller = viewRef
    }
    
    func popBack(route: SceneCase) {
        switch route {
        default:
            controller?.navigationController?.popViewController(animated: true)
        }
    }
}
