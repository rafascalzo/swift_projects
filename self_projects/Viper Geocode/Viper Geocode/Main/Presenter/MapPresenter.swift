//
//  MapPresenter.swift
//  Viper Geocode
//
//  Created by rafaeldelegate on 8/10/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//
//  Presenter — Contains the view logic for preparing content for display and for reacting to user interactions.

import UIKit
class MapPresenter: MapPresenterProtocol {
    
    var wireframe: MapWireFrameProtocol?
    var view: MapViewProtocol?
    var interactor: MapInputInteractorProtocol?
    var presenter: MapPresenterProtocol?
    
//    func showFruitSelection(with fruit: Fruit, from view: UIViewController) {
//        wireframe?.pushToFruitDetail(with: fruit, from: view)
//    }
    
    func viewDidLoad() {
        self.loadPinList()
        interactor?.setupMapConfiguration()
    }
    func loadPinList() {
        print("nada no viewDidLoad")
        interactor?.getPinList()
    }
}
extension MapPresenter: MapOutputInteractorProtocol {
    
    func setupMapConfiguration() {
        print("output interactore center view on user location")
        view?.setupMapConfiguration()
    }
    func printText(_ text: String) {
        print("output interactor")
        view?.printText(text)
    }
    
    func pinListDidFetch(pinList: [Pin]) {
        view?.reloadMapItens(with: pinList)
    }
    
}
