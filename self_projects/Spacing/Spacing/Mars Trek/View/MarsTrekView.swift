//
//  MarsTrekView.swift
//  Spacing
//
//  Created by FulltrackMobile on 06/06/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import UIKit

class MarsTrekView: UIViewController, MarsTrekViewProtocol {
    
    var presenter: MarsTrekPresenterProtocol?
    
    @IBOutlet var tileContainerView: UIView!
    
    let numberViewPerRow = 15
    var cells = [String:UIView]()
    var selectedCell: UIView?
    
    override func loadView() {
        super.loadView()
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MarsTrekWireframe.createModule(viewRef: self)
        presenter?.viewDidLoad()
    }
    
    func render() {
        let maxHeight = tileContainerView.frame.height
        
        let width = tileContainerView.frame.width / CGFloat(numberViewPerRow)
        
        let maxItens = Int(maxHeight / width)
        
        for j in 0...maxItens {
            for i in 0...numberViewPerRow {
                let cellView = UIView()
                cellView.backgroundColor = randomColor()
                
                cellView.frame = CGRect(x: CGFloat(i) * width, y: CGFloat(j) * width, width: width, height: width)
                cellView.layer.borderColor = UIColor.black.cgColor
                cellView.layer.borderWidth = 0.5
                tileContainerView.addSubview(cellView)
                
                let key = "\(i) | \(j)"
                cells[key] = cellView
            }
        }
        
        tileContainerView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan(gesture:))))
    }
    
    func show(error: String) {
        removeActivityIndicator()
        showAlert(error)
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer){
        let location = gesture.location(in: self.tileContainerView)
        
        
        /*print(location)
         
         var     loopCount = 0
         
         for subview in view.subviews{
         if subview.frame.contains(location){
         print("loopCount: ", loopCount)
         }
         loopCount += 1
         }*/
        
        let width = tileContainerView.frame.width / CGFloat(numberViewPerRow)
        
        let i = Int(location.x / width)
        let j = Int(location.y / width)
        print(i , j)
        
        let key = "\(i) | \(j)"
        guard let cellView = cells[key] else{return}
        
        if selectedCell != cellView{
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.selectedCell?.layer.transform = CATransform3DIdentity
            }, completion: nil)
        }
        
        selectedCell = cellView
        
        view.bringSubviewToFront(cellView)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            cellView.layer.transform = CATransform3DMakeScale(3, 3, 3)
        }, completion: nil)
        
        if gesture.state == .ended {
            
            UIView.animate(withDuration: 0.5, delay: 0.25, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                cellView.layer.transform = CATransform3DIdentity
            }) { (_) in
                
            }
        }
    }
    
    fileprivate func randomColor() -> UIColor{
        
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}
