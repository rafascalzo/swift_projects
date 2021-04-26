//
//  TestView.swift
//  Marvel
//
//  Created by rafaeldelegate on 7/13/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//


import UIKit
import SnapKit
import Lottie

struct Thumbnails {
    
    var titulo:String
    var image:String
    var description:String
    
}
class ViewMain: UIView{
    
    struct Constants {
        
        static let screenSize:CGSize = UIScreen.main.bounds.size
        static let device = UIDevice.current.userInterfaceIdiom
        static let layoutGuide = UILayoutGuide()
        
        static let customCellIdentifier = "cellIdentifier"
        
        static let cellHeight:CGFloat = device == .phone ? 180 : 380
        static let padding:CGFloat = Constants.screenSize.width * 0.09
        static let paddingTop:CGFloat = Constants.device == .phone ? 16 : 32
        static let height:CGFloat = Constants.device == .phone ? 44 : 88
        static let spaceInterItens:CGFloat = Constants.device == .phone ? 15 : 30
        static let quizButtonRadius:CGFloat = Constants.device == .phone ? 35 : 70
        static let switchMenuTopMargin : CGFloat = Constants.screenSize.height * 0.25
        
        static let switchHeight:CGFloat = Constants.screenSize.height * 0.10
        static let switchWidth:CGFloat = Constants.screenSize.width * 0.35
        
        static let searchBarPlaceholderText = "Search your favorite hero"
        static let quizLabelTitle = "Marvel Quiz"
        
        static let buttonTryAgainRadius:CGFloat = Constants.screenSize.width * 0.07
        
        static let offsetAnimationNotFound:CGFloat = Constants.screenSize.height * 0.25
        static let animationNotFoundHeight:CGFloat = Constants.screenSize.width * 0.40
    }
    
    var charFiltered : Array<Thumbnails> = []
    var allCharacteres : Array<Thumbnails> = []
    var delegate : ViewMainDelegate?
    
    // MARK :- Header
    var searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        let localizedString = NSLocalizedString(Constants.searchBarPlaceholderText, comment: "")
        searchBar.placeholder = localizedString
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.returnKeyType = .done
        searchBar.searchBarStyle = .minimal
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.searchBarFontColor, NSAttributedString.Key.font: UIFont.searchBarFont as Any]
        return searchBar
    }()
    let viewHeader : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    var backgroundImage : UIImageView = {
        var image = UIImageView(image: UIImage(named: "marvel"))
        image.contentMode = UIView.ContentMode.scaleAspectFill
        return image
    }()
    var bluredView : UIView = {
        var view = UIView()
        view.alpha = 0
        return view
    }()
    let animationView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 23/255, green: 23/255, blue: 23/255, alpha: 1)
        return view
    }()
    var viewMenu : UIView = {
        let menu = UIView()
        menu.setColoredLightLayer(.black)
        menu.isUserInteractionEnabled = true
        return menu
    }()
    var notFoundedAnimation : AnimationView = {
        let animation = AnimationView()
        animation.setupAnimation(named: "oops", withSpeed: nil, loopMode: .loop, size: nil)
        return animation
    }()
    var viewError:UIView = {
        let view = UIView()
        view.backgroundColor =  UIColor(red: 23/255, green: 23/255, blue: 23/255, alpha: 1)
        return view
    }()
    let loadingAnimation:AnimationView = {
        let animation = AnimationView()
        animation.setupAnimation(named: "black-deadpool", withSpeed: nil, loopMode: .loop, size: UIScreen.main.bounds.size)
        return animation
    }()
    
    var collectionViewCharacters : UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collectionView.register(CollectionViewCellCharacters.self, forCellWithReuseIdentifier: Constants.customCellIdentifier)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    let quizLabel : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: Constants.quizLabelTitle, textColor: .white, font: UIFont.titleFontMedium, backgroundColor: .clear)
        return label
    }()
    let quizButton : UIButton = {
        let button = UIButton()
        button.setupCircularImagedButton(named: "quiz-icon", radius: Constants.quizButtonRadius)
        button.addTarget(self, action: #selector(goToQuizGame(_:)), for: .touchUpInside)
        return button
    }()
    
    // Error components
    let labelTryAgain : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "Try again", textColor: .white, font: .textFontLarge, backgroundColor: .clear, textAlignment: .center)
        return label
    }()
    let buttonTryAgain : UIButton = {
        let button = UIButton()
        button.setupCircularImagedButton(named: "try-again-button", radius: Constants.buttonTryAgainRadius)
        button.addTarget(self, action: #selector(tryAgain(_:)), for: .touchUpInside)
        return button
    }()
    
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
        setupView()
    }
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    @objc func handleSwipes(_ recognizer: UISwipeGestureRecognizer){
        delegate?.handleSwipes(recognizer)
    }
    @objc func goToQuizGame(_ sender : Any){
        delegate?.goToQuizGame()
    }
    @objc func tryAgain(_ sender : Any){
        delegate?.tryAgain()
    }
    fileprivate func setupTapGestureMenu() {
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        
        let other = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        other.direction = .left
        
        viewMenu.addGestureRecognizer(leftSwipe)
        viewMenu.addGestureRecognizer(rightSwipe)
        bluredView.addGestureRecognizer(other)
        
    }
    
    func setupCellLayout(cellWidth:CGFloat){
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = Constants.spaceInterItens
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: cellWidth, height: Constants.cellHeight)
        
        collectionViewCharacters.collectionViewLayout = layout
    }
    
    func addBackgroundBlur(){
        addSubview(bluredView)
        bluredView.snp.makeConstraints { (make) in
            
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        bluredView.addBlur()
        bringSubviewToFront(bluredView)
        bringSubviewToFront(viewMenu)
    }
    
    func removeBackgroundBlur(){
        bluredView.removeFromSuperview()
    }
    
    func addnotFoundedAnimation(){
        
        addSubview(viewError)
        viewError.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        viewError.addSubview(notFoundedAnimation)
        viewError.bringSubviewToFront(notFoundedAnimation)
        notFoundedAnimation.snp.makeConstraints { (make) in
            make.topMargin.equalTo(Constants.offsetAnimationNotFound)
            make.centerX.equalToSuperview()
            make.width.equalTo(Constants.animationNotFoundHeight)
            make.height.equalTo(Constants.animationNotFoundHeight)
        }
        addSubview(labelTryAgain)
        labelTryAgain.snp.makeConstraints { (make) in
            make.top.equalTo(notFoundedAnimation.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        addSubview(buttonTryAgain)
        buttonTryAgain.snp.makeConstraints { (make) in
            make.top.equalTo(labelTryAgain.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(Constants.buttonTryAgainRadius * 2)
            make.height.equalTo(Constants.buttonTryAgainRadius * 2)
        }
        notFoundedAnimation.play()
    }
    
    func setupView() {
        
        let guide = UIScreen.main.bounds.height * 0.05
        
        let width = UIScreen.main.bounds.width
        let cellWidth = (width) - (2 * Constants.padding)
        setupCellLayout(cellWidth: cellWidth)
        backgroundColor = .blue
        
        addSubview(backgroundImage)
        
        backgroundImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        addSubview(viewHeader)
        viewHeader.snp.makeConstraints { (make) in
            make.topMargin.equalTo(guide)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(35)
        }
        
        viewHeader.addSubview(searchBar)
        searchBar.snp.makeConstraints { (make) in
            make.leading.equalTo(viewHeader).offset(Constants.padding)
            make.trailing.equalTo(viewHeader).inset(Constants.padding)
            make.height.equalTo(viewHeader)
        }
        
        addSubview(collectionViewCharacters)
        collectionViewCharacters.snp.makeConstraints { (make) in
            make.top.equalTo(viewHeader.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(Constants.padding)
            make.trailing.equalToSuperview().inset(Constants.padding)
            make.bottom.equalToSuperview().inset(-Constants.padding)
        }
        
        //MARK :- LATERAL MENU
        
        viewMenu.addSubview(quizLabel)
        quizLabel.snp.makeConstraints { (make) in
            make.topMargin.equalTo(Constants.switchMenuTopMargin)
            make.centerX.equalToSuperview()
        }
        viewMenu.addSubview(quizButton)
        quizButton.snp.makeConstraints { (make) in
            make.top.equalTo(quizLabel.snp.bottom).offset(15)
            make.centerX.equalTo(quizLabel)
            make.width.equalTo(Constants.quizButtonRadius)
            make.height.equalTo(Constants.quizButtonRadius)
        }
        
        addSubview(viewMenu)
        viewMenu.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(-self.frame.width * 0.42)
            make.bottom.equalToSuperview()
            make.width.equalTo(self.frame.width * 0.5)
        }
        
        //MARK :- ANIMATION VIEW
        animationView.addSubview(loadingAnimation)
        
        loadingAnimation.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        addSubview(animationView)
        
        loadingAnimation.center = self.center
        loadingAnimation.loopMode = .loop
        animationView.snp.makeConstraints({ (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        })
        setupTapGestureMenu()
    }
}
