//
//  MapsView.swift
//  Spacing
//
//  Created by FulltrackMobile on 06/06/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import UIKit

class MapsView: UITabBarController {
    
    override func loadView() {
        super.loadView()
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.kohinoorDevanagariRegularLarge], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white, .font: UIFont.kohinoorDevanagariRegularLarge], for: .selected)
        
        UITabBar.appearance().backgroundColor = .black
        UITabBar.appearance().tintColor = .white
        tabBar.isOpaque = true
        
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var viewControllers = [UIViewController]()
        let moonTrekView = MoonTrekView(nibName: "MoonTrekView", bundle: .main)
        moonTrekView.tabBarItem = UITabBarItem(title: "Moon", image: nil, tag: 0)
        let vestaTrekView = VestaTrekView(nibName: "VestaTrekView", bundle: .main)
        vestaTrekView.tabBarItem = UITabBarItem(title: "Vesta", image: nil, tag: 1)
        let marsTrekView = MarsTrekView(nibName: "MarsTrekView", bundle: .main)
        marsTrekView.tabBarItem = UITabBarItem(title: "Mars", image: nil, tag: 2)
        viewControllers = [moonTrekView,vestaTrekView,marsTrekView]
        
        self.viewControllers = viewControllers
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
}
