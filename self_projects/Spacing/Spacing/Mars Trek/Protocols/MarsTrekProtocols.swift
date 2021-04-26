//
//  MarsTrekProtocols.swift
//  Spacing
//
//  Created by rvsm on 06/06/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import Foundation

protocol MarsTrekViewProtocol: class {
    
    var presenter: MarsTrekPresenterProtocol? { get set }
    
    func show(error: String)
    func render()
}

protocol MarsTrekInputInteractorProtocol: class {
    
    var output: MarsTrekOutputInteractorProtocol? { get set }
    func fetch(mosaic: MarsMosaics, row: Int, column: Int, zoomLevel: Int)
}

protocol MarsTrekPresenterProtocol: class {
    
    var view: MarsTrekViewProtocol? { get set }
    var interactor: MarsTrekInputInteractorProtocol? { get set }
    var wireframe: MarsTrekWireframeProtocol? { get set }
    
    func viewDidLoad()
}

protocol MarsTrekOutputInteractorProtocol: class {
    
    func show(error: String)
}

protocol MarsTrekWireframeProtocol: class {
    
    var controller: MarsTrekView? { get set }
    
    static func createModule(viewRef: MarsTrekView)
    
    func popBack(route: SceneCase)
}
