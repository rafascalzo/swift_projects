//
//  SpaceMainProtocols.swift
//  YSpace
//
//  Created by Rafael VSM on 31/01/20.
//  Copyright © 2020 Rafael VSM. All rights reserved.
//

import Foundation
import UIKit

protocol SpaceMainViewProtocol: class {
    
    var presenter: SpaceMainPresenterProtocol? { get set }
    
    func render()
}

protocol SpaceMainInputInteractorProtocol: class {
    
}

protocol SpaceMainPresenterProtocol: class {
    
    var view: SpaceMainViewProtocol? { get set }
    var interactor: SpaceMainInputInteractorProtocol? { get set }
    var wireframe: SpaceMainWireframeProtocol? { get set }
    
    func viewDidLoad()
    func goTo(scene: Scene, from controller: UIViewController)
}

protocol SpaceMainOutputInteractorProtocol: class {
    
}

protocol SpaceMainWireframeProtocol: class {
    
    static func createModule(viewRef: SpaceMainView)
    
    func goTo(scene: Scene, from controller: UIViewController)
}
