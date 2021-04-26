//
//  EpicProtocols.swift
//  YSpace
//
//  Created by RVSM on 29/03/20.
//  Copyright © 2020 RVSM. All rights reserved.
//

import Foundation

protocol EpicViewProtocol: class {
    
    var presenter: EpicPresenterProtocol? { get set }
    
    func render()
}

protocol EpicInputInteractorProtocol: class {
    
}

protocol EpicPresenterProtocol: class {
    
    var view: EpicViewProtocol? { get set }
    var interactor: EpicInputInteractorProtocol? { get set }
    var wireframe: EpicWireframeProtocol? { get set }
    
    func viewDidLoad()
}

protocol EpicOutputInteractorProtocol: class {
    
}

protocol EpicWireframeProtocol: class {
    
    static func createModule(viewRef: EpicView)
}
