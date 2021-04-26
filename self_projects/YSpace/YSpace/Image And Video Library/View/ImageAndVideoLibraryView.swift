//
//  ImageAndVideoLibraryView.swift
//  YSpace
//
//  Created by RVSM on 29/03/20.
//  Copyright © 2020 Rafael Scalzo. All rights reserved.
//

import UIKit

class ImageAndVideoLibraryView: UIViewController {
    
    var presenter: ImageAndVideoLibraryPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ImageAndVideoLibraryWireframe.createModule(viewRef: self)
        presenter?.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension ImageAndVideoLibraryView: ImageAndViewLibraryViewProtocol {
    
    func render() {
        title = "image_and_video_library".localized
        view.backgroundColor = .systemGreen
    }
}
