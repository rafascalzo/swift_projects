//
//  ViewMarkerFormDelegate.swift
//  Full Square
//
//  Created by Fulltrack Mobile on 08/08/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import Foundation
import UIKit
protocol ViewMarkerFormDelegate : class {
    
    func selectMediaOrigin(_ option : MenuOptions)
    func backToPreviousController()
    func savePin(_ sender : Any)
    func addNewDiscipline(_ sender : Any)
    func showTableOptions(_ sender : Any)
    func cancelPhotoSelect(_ sender : Any)
    func checkLayoutStatus()
}
