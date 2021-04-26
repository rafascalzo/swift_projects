//
//  MainViewDelegate.swift
//  Full Square
//
//  Created by macbook-estagio on 30/07/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import Foundation
import UIKit
import MapKit
protocol MainViewDelegate : class {
   // func setupCollectionViewProtocols()
    func setupCustomSearchTextViewDelegate()
    func handleSwipes(_ gestures : [UISwipeGestureRecognizer])
    func handleLongPressGesture(_ recognizer : UILongPressGestureRecognizer)
    func handlePanGesture(_ sender : UIPanGestureRecognizer)
    
    func footerBarButtonAction(_ sender : Any)
    func startMapEdit() -> Void
    func configurePin(_ sender : Any)
    func searchBarAction()
    func cancelEditing(_ sender : Any)
//    func textFieldDidChange(_ textField : UITextField)
    func handleTapGesture(_ sender : Any)
    
    
}
