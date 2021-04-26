//
//  MarsRoverPresenter.swift
//  YSpace
//
//  Created by RVSM on 28/03/20.
//  Copyright © 2020 Rafael Scalzo. All rights reserved.
//

import UIKit

class MarsRoverPresenter: MarsRoverPresenterProtocol {
    
    func fetchByMartianSol(rover: RoverName, camera: RoverCamera?, sol: Int?, page: Int) {
        interactor?.fetchByMartianSol(rover: rover, camera: camera, sol: sol, page: page)
    }
    
    
    func fetchByEarthDate(rover: RoverName, camera: RoverCamera, date: Date?, page: Int) {
        interactor?.fetchByEarthDate(rover: rover, camera: camera, date: date, page: page)
    }
    
    func popBack(from: UIViewController) {
        wireframe?.popBack(from: from)
    }
    
    weak var view: MarsRoverViewProtocol?
    
    var interactor: MarsRoverInputInteractorProtocol?
    
    var wireframe: MarsRoverWireframeProtocol?
    
    func viewDidLoad() {
        view?.render()
    }
}

extension MarsRoverPresenter: MarsRoverOutputInteractorProtocol {
    func didFetch(roverPhotos: MarsRoverPhotos) {
        view?.didFetch(roverPhotos: roverPhotos)
    }
    
    func showError(_ message: String) {
        view?.showError(message)
    }
}
