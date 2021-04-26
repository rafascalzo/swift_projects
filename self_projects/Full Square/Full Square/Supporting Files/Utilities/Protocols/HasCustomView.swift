//
//  HasCustomView.swift
//  Full Square
//
//  Created by macbook-estagio on 30/07/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import UIKit
public protocol HasCustomView {
    associatedtype CustomView: UIView
}

extension HasCustomView where Self: UIViewController {
    
    /// The UIViewController's custom view.
    public var customView: CustomView {
        guard let customView = view as? CustomView else {
            fatalError("Expected view to be of type \(CustomView.self) but got \(type(of: view)) instead")
        }
        return customView
    }
}
