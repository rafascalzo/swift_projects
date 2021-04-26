//
//  PictureOfTheDayInputInteractor.swift
//  YSpace
//
//  Created by RVSM on 23/03/20.
//  Copyright © 2020 Rafael Scalzo. All rights reserved.
//

import Foundation

class PictureOfTheDayInputInteractor: PictureOfTheDayInputInteractorProtocol {
    
    func fetchImageBy(date: Date, hd: Bool) {
        NASAAPI.shared.fetchPictureOfTheDay(date: date, hd: hd) { data, error in
            if let result = data {
                self.output?.didReceived(content: result)
            } else if let error = error {
                self.output?.showError(error)
            }
        }
    }
    
    weak var output: PictureOfTheDayOutputInteractorProtocol?
    
    func fetchContent() {
        let date = Date()
        NASAAPI.shared.fetchPictureOfTheDay(date: date, hd: true) { data, error in
            if let result = data {
                self.output?.didReceived(content: result)
            } else if let error = error {
                self.output?.showError(error)
            }
        }
    }
}
