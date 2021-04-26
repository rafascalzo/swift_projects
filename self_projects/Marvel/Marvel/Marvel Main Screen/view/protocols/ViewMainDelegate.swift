//
//  ViewMainDelegate.swift
//  Marvel
//
//  Created by rafaeldelegate on 7/28/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import Foundation
import UIKit

protocol ViewMainDelegate {
    func goToQuizGame()
    func handleSwipes(_ recognizer: UISwipeGestureRecognizer)
    func tryAgain()
}
