//
//  FruitListProtocols.swift
//  ViperDemo
//
//  Created by Abhisek on 08/11/17.
//  Copyright © 2017 Abhisek. All rights reserved.
//

import UIKit


protocol FruitListViewProtocol: class {
    // PRESENTER -> VIEW
    func showFruits(with fruits: [Fruit])
}

protocol FruitListPresenterProtocol: class {
    //View -> Presenter
    var interactor: FruitListInputInteractorProtocol? {get set}
    var view: FruitListViewProtocol? {get set}
    var wireframe: FruitListWireFrameProtocol? {get set}

    func viewDidLoad()
    func showFruitSelection(with fruit: Fruit, from view: UIViewController)
}

protocol FruitListInputInteractorProtocol: class {
    var presenter: FruitListOutputInteractorProtocol? {get set}
    //Presenter -> Interactor
    func getFruitList()
}

protocol FruitListOutputInteractorProtocol: class {
    //Interactor -> Presenter
    func fruitListDidFetch(fruitList: [Fruit])
}

protocol FruitListWireFrameProtocol: class {
    //Presenter -> Wireframe
    func pushToFruitDetail(with fruit: Fruit,from view: UIViewController)
    static func createFruitListModule(fruitListRef: FruitListView)
}
