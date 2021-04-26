//
//  ImagePicker.swift
//  Full Square
//
//  Created by rafaeldelegate on 8/3/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import Foundation
import UIKit

class ImagePicker : NSObject, UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    // MARK: - Attributes
    var delegate : ImagePickerDelegate?
    
    // MARK: - Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        let fixedImage = image.fixOrientation()
        
        delegate?.changeImage(fixedImage)
        picker.dismiss(animated: true, completion: nil)
    }
}
