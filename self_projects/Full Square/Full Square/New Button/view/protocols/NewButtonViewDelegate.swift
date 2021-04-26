//
//  NewButtonViewDelegate.swift
//  Full Square
//
//  Created by Fulltrack Mobile on 13/08/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import UIKit

protocol NewButtonViewDelegate : class {
    
    func backToPreviousController(_ sender : Any)
    //func handleImageView(_ sender : Any)
    func saveButton(_ sender : Any)
    func handleTapGesture(_ sender : Any)
}
