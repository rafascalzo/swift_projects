//
//  MapProtocols.swift
//  Viper Geocode
//
//  Created by rafaeldelegate on 8/10/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

// PRESENTER -> VIEW. Presenter communicates with the view to make the necessary UI changes with the results from the Interactor.
protocol MapViewProtocol: class {
    
   // func showFruits(with fruits: [Fruit])
    func printText(_ text : String)
    func reloadMapItens(with itens:[Pin])
    func setupMapConfiguration()
}

//View -> Presenter. View communicates with the Presenter regarding all the user interactions and asks the presenter to perform necessary handlings regarding the same.
protocol MapPresenterProtocol: class {
    
    var interactor: MapInputInteractorProtocol? {get set}
    var view: MapViewProtocol? {get set}
    var wireframe: MapWireFrameProtocol? {get set}
    
    func viewDidLoad()
  //  func showFruitSelection(with fruit: Fruit, from view: UIViewController)
    func printText(_ text: String)
}

//Presenter -> Interactor. Presenter communicates with Interactor(The brain of the module) regarding user actions or data fetching actions.
protocol MapInputInteractorProtocol: class {
    var presenter: MapOutputInteractorProtocol? {get set}
    
    func getPinList()
    func setupMapConfiguration()
}

//Interactor -> Presenter. Interactor communicates with the presenter regarding the output of the business logic which has performed the necessary actions.
protocol MapOutputInteractorProtocol: class {
    
    func pinListDidFetch(pinList: [Pin])
    func printText(_ text: String)
    func setupMapConfiguration()
}

//Presenter -> Wireframe. Presenter communicates to router regarding navigation between pages.
protocol MapWireFrameProtocol: class {
    
   // func pushToFruitDetail(with fruit: Fruit,from view: UIViewController)
    static func createMapModule(mapRef: MapView)
}
