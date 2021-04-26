//
//  ImageAndVideoLibraryProtocols.swift
//  YSpace
//
//  Created by RVSM on 29/03/20.
//  Copyright © 2020 RVSM. All rights reserved.
//

import Foundation

protocol ImageAndViewLibraryViewProtocol: class {
    
    var presenter: ImageAndVideoLibraryPresenterProtocol? { get set }
    
    func render()
}

protocol ImageAndVideoLibraryInputInteractorProtocol: class {
    
    func search()
}

protocol ImageAndVideoLibraryPresenterProtocol: class {
    
    var view: ImageAndViewLibraryViewProtocol? { get set }
    var interactor: ImageAndVideoLibraryInputInteractorProtocol? { get set }
    var wireframe: ImageAndVideLibraryWireframeProtocol? { get set }
    
    func viewDidLoad()
}

protocol ImageAndVideoLibraryOutputInteractorProtocol: class {
    
}

protocol ImageAndVideLibraryWireframeProtocol: class {
    
    static func createModule(viewRef: ImageAndVideoLibraryView)
    
}



