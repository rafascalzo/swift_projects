//
//  MarsRoverWireframe.swift
//  YSpace
//
//  Created by RVSM on 28/03/20.
//  Copyright © 2020 RVSM. All rights reserved.
//

import UIKit

class MarsRoverWireframe: MarsRoverWireframeProtocol {
    
    func popBack(from: UIViewController) {
        if let controller = from as? MarsRoverView {
            controller.navigationController?.popViewController(animated: true)
        }
    }
    
    static func createModule(viewRef: MarsRoverViewProtocol) {
        let presenter: MarsRoverPresenterProtocol & MarsRoverOutputInteractorProtocol = MarsRoverPresenter()
        viewRef.presenter = presenter
        viewRef.presenter?.interactor = MarsRoverInputInteractor()
        viewRef.presenter?.interactor?.output = presenter
        viewRef.presenter?.view = viewRef
        viewRef.presenter?.wireframe = MarsRoverWireframe()
        
    }
    
    deinit {
        print("deinit")
    }
}
