//
//  ImageAndVideoLibraryInputInteractor.swift
//  Spacing
//
//  Created by rvsm on 11/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import Foundation

class ImageAndVideoLibraryInputInteractor: ImageAndVideoLibraryInputInteractorProtocol {
    
    weak var output: ImageAndVideoLibraryOutputInteractorProtocol?
    
    func search(_ text: String?) {
        let input = LibrarySearchParameters(authenticated: false, searchTherm: text!, center: nil, description: nil, description508: nil, keywords: nil, location: nil, mediaType: nil, nasaId: nil, page: nil, photographer: nil, secondaryCreator: nil, title: nil, yearStart: nil, yearEnd: nil)
        NASAAPI.search(parameters: input) { (data, error) in
            if let error = error {
                self.output?.show(error: error)
            } else if let data = data {
                self.output?.didFetch(data: data)
            }
        }
    }
    
    func search(therm: String? = nil, center: String? = nil, description: String? = nil, description508: String? = nil, keywords: String? = nil, location: String? = nil, mediaType: String? = nil, nasaId: String? = nil, page: Int? = nil, photographer: String? = nil, secondaryCreator: String? = nil, title: String? = nil, yearStart: String? = nil, yearEnd: String? = nil) {
        
    }
    
    func search() {
        let input = LibrarySearchParameters(authenticated: false, searchTherm: "apollo 11", center: nil, description: "moon landing", description508: nil, keywords: nil, location: nil, mediaType: "image", nasaId: nil, page: 1, photographer: nil, secondaryCreator: nil, title: nil, yearStart: nil, yearEnd: nil)
        NASAAPI.search(parameters: input) { (data, error) in
            if let error = error {
                self.output?.show(error: error)
            } else if let data = data {
                self.output?.didFetch(data: data)
            }
        }
    }
}
