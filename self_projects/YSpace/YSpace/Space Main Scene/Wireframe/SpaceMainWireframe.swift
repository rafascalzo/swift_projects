//
//  SpaceMainWireframe.swift
//  YSpace
//
//  Created by Rafael VSM on 31/01/20.
//  Copyright © 2020 Rafael VSM. All rights reserved.
//

import Foundation
import UIKit

class SpaceMainWireframe: SpaceMainWireframeProtocol {
    
    func goTo(scene: Scene, from controller: UIViewController) {
        guard let controller = controller as? SpaceMainView else { return }
        switch scene.scene {
        case .PICTURE_OF_THE_DAY:
            controller.navigationController?.pushViewController(PictureOfTheDayView(), animated: true)
        case .MARS:
            let layout = UICollectionViewFlowLayout()
            controller.navigationController?.pushViewController(MarsRoverView(collectionViewLayout: layout), animated: true)
        case .IMAGE_AND_VIDEO_LIBRARY:
            controller.navigationController?.pushViewController(ImageAndVideoLibraryView(), animated: true)
        case .EPIC:
            controller.navigationController?.pushViewController(EpicView(), animated: true)
        default:
            print("nowhere to go", #file, #function, #line)
        }
    }
    
    static func createModule(viewRef: SpaceMainView) {
        
        let presenter: SpaceMainPresenterProtocol & SpaceMainOutputInteractorProtocol = SpaceMainPresenter()
        viewRef.presenter = presenter
        viewRef.presenter?.interactor = SpaceMainInputInteractor()
        viewRef.presenter?.view = viewRef
        viewRef.presenter?.wireframe = SpaceMainWireframe()
    }
    
    deinit {
        print("SpaceMainWireframe has removed")
    }
    
}
