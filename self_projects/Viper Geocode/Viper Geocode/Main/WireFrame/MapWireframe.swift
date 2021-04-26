//
//  MapWireframe.swift
//  Viper Geocode
//
//  Created by rafaeldelegate on 8/10/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit

class MapWireframe: MapWireFrameProtocol {
    
    func pushToFruitDetail(with fruit: Pin,from view: UIViewController) {
//        let fruitDetailViewController = view.storyboard?.instantiateViewController(withIdentifier: "FruitDetailView") as! FruitDetailView
//        FruitDetailWireFrame.createFruitDetailModule(with: fruitDetailViewController, and: fruit)
//        view.navigationController?.pushViewController(fruitDetailViewController, animated: true)
    }
    
    class func createMapModule(mapRef: MapView) {
        let presenter: MapPresenterProtocol & MapOutputInteractorProtocol = MapPresenter()
        
        mapRef.presenter = presenter
        mapRef.presenter?.wireframe = MapWireframe()
        mapRef.presenter?.view = mapRef
        mapRef.presenter?.interactor = MapInteractor()
        mapRef.presenter?.interactor?.presenter = presenter
    }
    
}
