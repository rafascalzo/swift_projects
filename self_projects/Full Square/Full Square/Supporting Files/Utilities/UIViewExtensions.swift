//
//  UIViewExtensions.swift
//  Full Square
//
//  Created by macbook-estagio on 01/08/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//



import Foundation
import UIKit

enum ShadowOptions {
    case leftBottom
    case leftTop
    case rightBottom
    case rightTop
    case bottom
    case top
    case left
    case right
}

extension UIView {
    
    // In order to create computed properties for extensions, we need a key to store and access the stored property
    fileprivate struct AssociatedObjectKeys {
        static var tapGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
        static var longPressGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
        static var panGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
        static var swipeGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
    }
    
    fileprivate typealias Handler = () -> Void
    
    fileprivate typealias TapAction = Handler?
    fileprivate typealias LongPressAction = Handler?
    fileprivate typealias PanAction = Handler?
    fileprivate typealias SwipeAction = Handler?
    
    // Set our computed property type to a closure
    fileprivate var tapGestureRecognizerAction: TapAction? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer) as? TapAction
            return tapGestureRecognizerActionInstance
        }
    }
    fileprivate var longPressGestureRecognizerAction: LongPressAction? {
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedObjectKeys.longPressGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let longPressGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.longPressGestureRecognizer) as? LongPressAction
            return longPressGestureRecognizerActionInstance
        }
    }
    fileprivate var swipeGestureRecognizerAction: SwipeAction? {
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedObjectKeys.swipeGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let swipeGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.swipeGestureRecognizer) as? SwipeAction
            return swipeGestureRecognizerActionInstance
        }
    }
    fileprivate var panGestureRecognizerAction: PanAction? {
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedObjectKeys.panGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let panGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.panGestureRecognizer) as? PanAction
            return panGestureRecognizerActionInstance
        }
    }
    
    // This is the meat of the sauce, here we create the tap gesture recognizer and
    // store the closure the user passed to us in the associated object we declared above
    public func addTapGestureRecognizer(action: (() -> Void)?) {
        self.isUserInteractionEnabled = true
        self.tapGestureRecognizerAction = action
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        tapGestureRecognizer.cancelsTouchesInView = false
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // Every time the user taps on the UIView, this function gets called,
    // which triggers the closure we stored
    @objc fileprivate func handleTapGesture(sender: UITapGestureRecognizer) {
        if let action = self.tapGestureRecognizerAction {
            action?()
        } else {
            print("no action")
        }
    }
    
    public func addLongPressGestureRecognizer(action: (() -> Void)?){
        self.isUserInteractionEnabled = true
        self.longPressGestureRecognizerAction = action
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture))
        self.addGestureRecognizer(longPressGestureRecognizer)
    }
    @objc fileprivate func handleLongPressGesture(sender: UILongPressGestureRecognizer) {
        if let action = self.longPressGestureRecognizerAction {
            action?()
        } else {
            print("no action")
        }
    }
    public func addSwipeGestureRecognizer(action: (() -> Void)?){
        self.isUserInteractionEnabled = true
        self.swipeGestureRecognizerAction = action
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        
        self.addGestureRecognizer(leftSwipe)
        self.addGestureRecognizer(rightSwipe)
        
    }
    @objc fileprivate func handleSwipes(sender: UISwipeGestureRecognizer) {
        if let action = self.swipeGestureRecognizerAction {
            action?()
        } else {
            print("no action")
        }
    }
    
    public func addPanGestureRecognizer(action: (() -> Void)?){
        self.isUserInteractionEnabled = true
        self.panGestureRecognizerAction = action
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        self.addGestureRecognizer(panGestureRecognizer)
    }
    @objc fileprivate func handlePanGesture(sender: UIPanGestureRecognizer) {
        if let action = self.panGestureRecognizerAction {
            action?()
        } else {
            print("no action")
        }
    }
    
    static let blurEffectView : UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blur = UIVisualEffectView(effect: blurEffect)
        blur.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blur
    }()
    
    // MARK: - Methods
    func addShadow(_ color : UIColor , shadowOptions : ShadowOptions) -> Void{
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = 0.25
        self.layer.shadowOpacity = 0.77
        
        switch shadowOptions {
            
        case .top:
            self.layer.shadowOffset = CGSize(width: 0, height: -1)
            break
        case .bottom :
            self.layer.shadowOffset = CGSize(width: 0, height: 1)
            break
        case .left :
            self.layer.shadowOffset = CGSize(width: -1, height: 0)
            break
        case .right :
            self.layer.shadowOffset = CGSize(width: 1, height: 0)
            break
        case .leftBottom :
            self.layer.shadowOffset = CGSize(width: -1, height: 1)
            break
        case .leftTop :
            self.layer.shadowOffset = CGSize(width: -1, height: -1)
            break
        case .rightBottom :
            self.layer.shadowOffset = CGSize(width: 1, height: 1)
            break
        case .rightTop :
            self.layer.shadowOffset = CGSize(width: 1, height: -1)
            break
        }
    }
    
    func setupLightBorders(withColor color : UIColor) -> Void {
        layer.masksToBounds = true
        layer.borderColor = color.cgColor
        layer.borderWidth = 0.25
    }
    
//    func setupCircularComponent (radius: CGFloat) {
//        layer.cornerRadius = radius
//    }
    
    func makeCircular(with diameter:CGFloat?) {
        if let diameter = diameter {
            layer.cornerRadius = diameter / 2
        }
    }
    
    func addBlur(){
        UIView.blurEffectView.alpha = 0.5
        UIView.blurEffectView.frame = self.bounds
        addSubview(.blurEffectView)
    }
    func removeBlur() {
        UIView.blurEffectView.frame = .zero
        UIView.blurEffectView.removeFromSuperview()
    }
    func adjustScaleImage(){
        self.contentMode = .scaleAspectFill
    }
    
}
