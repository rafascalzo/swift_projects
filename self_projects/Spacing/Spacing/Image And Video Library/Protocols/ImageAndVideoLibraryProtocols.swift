//
//  ImageAndVideoLibraryProtocols.swift
//  Spacing
//
//  Created by rvsm on 11/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import Foundation

protocol ImageAndVideoLibraryViewProtocol: class {
    
    var presenter: ImageAndVideoLibraryPresenterProtocol? { get set }
    
    func render()
    func show(error: String)
    func didFetch(data: ImageVideLibraryDataWrapper)
    func showLoading()
    func removeLoading()
}

protocol ImageAndVideoLibraryInputInteractorProtocol: class {
    var output: ImageAndVideoLibraryOutputInteractorProtocol? { get set }
    
    func search()
    func search(_ text: String?)
}

protocol ImageAndVideoLibraryPresenterProtocol: class {
    
    var view: ImageAndVideoLibraryViewProtocol? { get set }
    var interactor: ImageAndVideoLibraryInputInteractorProtocol? { get set }
    var wireframe: ImageAndVideLibraryWireframeProtocol? { get set }
    
    func viewDidLoad()
    func search(_ text: String?)
}

protocol ImageAndVideoLibraryOutputInteractorProtocol: class {
    
    func show(error: String)
    func didFetch(data: ImageVideLibraryDataWrapper)
}

protocol ImageAndVideLibraryWireframeProtocol: class {
    
    var controller: ImageAndVideoLibraryView? { get set }
    static func createModule(viewRef: ImageAndVideoLibraryView)
}
