//
//  MarsTrekInputInteractor.swift
//  Spacing
//
//  Created by rvms on 06/06/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import Foundation

/*
 Here is basic information about how to request image tiles from RESTful WMTS service. The basic URL template is as follow.

  http://{host}/catalog/{product name}/1.0.0/{Style}/{TileMatrixSet}/{TileMatrix}/{TileRow}/{TileCol}.png
 * Some service is .png some are .jpg. Please look at WMTS GetCapabilities ResourcesURL element to find out what extention to use.

 In order to fill in the varialbes in the template URL, you need to parse WMTS GetCapabilities XML. GetCapabilities XML can be found for each products below.

 From the WMTS GetCapabilities XML, find ows:Identifier element inside Style element. This value replaces {Style}. ows:Identifier element inside TileMatrixSet element replaces {TileMatrixSet}. Inside TileMatrixSet element in WMTS Capabilities, there is a list of TileMatrix. This is the Zoom level. Replace {TileMatrix} with the ows:Identifier found in TileMatrix element.

 {TileRow} and {TileCol} are row and col index for tiles. The first zoom level for product that covers whole globe will have two columns and one row so the URLs are as follow:

 https://api.nasa.gov/mars-wmts/catalog/Mars_MO_THEMIS-IR-Day_mosaic_global_100m_v12_clon0_ly/1.0.0/default/default028mm/0/0/0.jpg
 https://api.nasa.gov/mars-wmts/catalog/Mars_MO_THEMIS-IR-Day_mosaic_global_100m_v12_clon0_ly/1.0.0/default/default028mm/0/0/1.jpg
 The second zoom level has four columns and two rows and so on.

 If the image tile is missing, that means there is no data coverage in that area. You can also use coverage Bbox to calcuate the coverage before request image tiles.
 */

public enum imageExtension {
    case png, jpg
    
    var value: String {
        switch self {
        case .png: return "png"
        case .jpg: return "jpg"
        }
    }
}

public enum TileMatrixSet {
    
    case `default`
    
    var value: String {
        switch self {
        case .`default`: return "default028mm"
        }
    }
}

class MarsTrekInputInteractor: MarsTrekInputInteractorProtocol {
    
    weak var output: MarsTrekOutputInteractorProtocol?
    
    func fetch(mosaic: MarsMosaics, row: Int, column: Int, zoomLevel: Int) {
        // /1.0.0/{Style}/{TileMatrixSet}/{TileMatrix}/{TileRow}/{TileCol}.png
        let `extension` = "png"
        let endpoint = mosaic.wmtsEndpoint + "/1.0.0" + "/default" + "/default028mm" + "/\(zoomLevel)" + "/\(row)" + "/\(column)" + ".\(`extension`)"
        print(endpoint)
    }
    
}
