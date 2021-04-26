//
//  ViewDiscovery.swift
//  Marvel
//
//  Created by rafaeldelegate on 7/20/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//
import UIKit
import Lottie

public class ViewDiscovery: UIView {
    
    struct Constants {
        
        static let device = UIDevice.current.userInterfaceIdiom
        static let screenFrame = UIScreen.main.bounds
        static let guide = UIScreen.main.bounds.height * 0.02
        static let imageHeight:CGFloat = Constants.device == .phone ? Constants.screenFrame.height * 0.37 : Constants.screenFrame.height * 0.38
        static let imageTitleHeight:CGFloat = Constants.device == .phone ? Constants.screenFrame.width * 0.07 : Constants.screenFrame.width * 0.07
        static let padding:CGFloat = Constants.device == .phone ? Constants.screenFrame.width * 0.03 : Constants.screenFrame.width * 0.03
        
        static let homeButtonHeight:CGFloat = Constants.device == .phone ? Constants.screenFrame.width * 0.07 : Constants.screenFrame.width * 0.07
        static let tipsViewRadius:CGFloat = Constants.screenFrame.width * 0.05
        
        static let scoreHeight:CGFloat = Constants.device == .phone ? Constants.screenFrame.width * 0.07 : Constants.screenFrame.width * 0.07
        static let scoreWidth:CGFloat = Constants.device == .phone ? 300 : 500
        
        static let helpButtonRadius:CGFloat = Constants.device == .phone ? Constants.screenFrame.width * 0.085 : Constants.screenFrame.width * 0.085
        
        static let tipsOptionsWidth:CGFloat = Constants.screenFrame.width - 4 * Constants.padding
        static let hintOptionsHeight:CGFloat = Constants.screenFrame.height * 0.17
        
        static let tipsButtonsHeingt:CGFloat = Constants.screenFrame.width * 0.07
        
        static let answerAnimationHeight:CGFloat = Constants.device == .phone ? Constants.screenFrame.width * 0.12 : Constants.screenFrame.width * 0.12
        static let answerAnimationPadding:CGFloat = Constants.screenFrame.width * 0.015
        
        static let answersButtonHeight: CGFloat = Constants.screenFrame.height * 0.05
        
        static let switchHeight:CGFloat = Constants.screenFrame.height * 0.09
        static let switchWidth:CGFloat = Constants.screenFrame.width * 0.35
        
    }
    // MARK :- ViewDelegate
    weak var delegate : DiscoveryViewDelegate?
    
    // MARK :- Background
    let backgroundImage:UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "marvel")
        image.contentMode = .scaleAspectFill
        image.alpha = 0.5
        return image
    }()
    
    //MARK :- Header Menu
    var labelScore: UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "Score", textColor: .white, font: UIFont.scoreFont, backgroundColor: .clear)
        return label
    }()
    
    var homeButton : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(backtoHome(_:)), for: .touchUpInside)
        button.setImage(UIImage(named: "back-arrow"), for: .normal)
        return button
    }()
    
    var helpButton:UIButton = {
        let button = UIButton()
        button.setupCircularImagedButton(named: "help", radius: Constants.helpButtonRadius)
        button.addTarget(self, action: #selector(showTipsOptions(_:)), for: .touchUpInside)
        return button
    }()
    var comicTipsButton: UIButton = {
        let button = UIButton()
        button.setupCircularImagedButton(named: "comics", radius: Constants.homeButtonHeight)
        button.addTarget(self, action: #selector(showTips(_:)), for: .touchUpInside)
        button.tag = 0
        button.alpha = 0
        return button
    }()
    var seriesTipsButton: UIButton = {
        let button = UIButton()
        button.setupCircularImagedButton(named: "series", radius: Constants.homeButtonHeight)
        button.addTarget(self, action: #selector(showTips(_:)), for: .touchUpInside)
        button.tag = 1
        button.alpha = 0
        return button
    }()
    var eventsTipsButton: UIButton = {
        let button = UIButton()
        button.setupCircularImagedButton(named: "events", radius: Constants.homeButtonHeight)
        button.addTarget(self, action: #selector(showTips(_:)), for: .touchUpInside)
        button.tag = 2
        button.alpha = 0
        return button
    }()
    let comicTipsLabel:UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "Comic Tips", textColor: .white ,font: .textFontMedium, backgroundColor: .clear, textAlignment: .center)
        label.alpha = 0
        label.sizeToFit()
        return label
    }()
    let seriesTipsLabel:UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "Series Tips",textColor: .white, font: .textFontMedium, backgroundColor: .clear, textAlignment: .center)
        label.alpha = 0
        label.sizeToFit()
        return label
    }()
    let eventsTipsLabel:UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "Events Tips", textColor: .white ,font: .textFontMedium, backgroundColor: .clear, textAlignment: .center)
        label.alpha = 0
        label.sizeToFit()
        return label
    }()
    
    // MARK : - Image
    var imageViewCard : UIImageView = {
        let image = UIImageView()
        image.setColoredLightBorders(color: .lightGray)
        image.contentMode = .scaleAspectFill
        return image
    }()
    var bluredView : UIView = {
        let view = UIView()
        view.setColoredLightBorders(color: .lightGray)
        view.addBlur()
        return view
    }()
    var labelImageTitle: UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: nil, textColor: UIColor.white, font: .titleFontLarge, backgroundColor: .clear)
        return label
    }()
    // MARK Tips view
    var tipsBackground : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "tips-background")
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        return imageView
    }()
    var tipsContainerView : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 25
        view.backgroundColor = UIColor(red: 255/255, green: 58/255, blue: 0/255, alpha: 1)
        view.alpha = 0
        view.layer.masksToBounds = true
        return view
    }()
    
    var tipTextView : UITextView = {
        let textView = UITextView()
        textView.setBasics(text: "", font: .textFontLarge, textColor: .white, allignment: .center
            , .clear, isEditable: false, withInteraction: true)
        return textView
    }()
    
    // MARK : - Answer Animations
    var correctAnimationView : AnimationView = {
        let animation = AnimationView()
        animation.setupAnimation(named: "correct-answer", withSpeed: 2, loopMode: .playOnce, size: nil)
        return animation
    }()
    var wrongAnimationView : AnimationView = {
        let animation = AnimationView()
        animation.setupAnimation(named: "wrong-answer", withSpeed: 2, loopMode: .playOnce, size: nil)
        return animation
    }()
    
    // MARK :- SWITCH BUTTON
    
    //    let switchLabel : UILabel = {
    //        let label = UILabel()
    //        let text = "Dark Theme"
    //        label.setBasicLabel(text: text, textColor: .white, font: .titleFontMedium, backgroundColor: .clear)
    //        return label
    //    }()
    //    
    //    var animatedSwitch : AnimatedSwitch = {
    //        let animationView = AnimatedSwitch()
    //        animationView.animation = Animation.named("stop-go-radio-button")
    //        animationView.clipsToBounds = false
    //        
    //        /// Set animation play ranges for touch states
    //        animationView.setProgressForState(fromProgress: 0, toProgress: 0.5, forOnState: true)
    //        animationView.setProgressForState(fromProgress: 0.5, toProgress: 1, forOnState: false)
    //        animationView.isOn = false
    //        animationView.isUserInteractionEnabled = true
    //        animationView.addTarget(self, action: #selector(setupEasyMode(_:)), for: .touchUpInside)
    //        return animationView
    //    }()
    //    @objc func setupEasyMode(_ sender : Any){
    //        delegate?.toggleEasyMode(sender)
    //    }
    
    var textHint : String = ""
    
    // MARK : - Answer Buttons
    var tagAnswerButtons:Int = 0
    var answerButtonsContainerView : UIView = {
        let view = UIView()
        return view
    }()
    var stackViewButtons : UIStackView = {
        let padding:CGFloat = 8
        let stackView = UIStackView()
        stackView.setupStackViewRelativeArrangement(axis: .vertical, distribution: nil, padding: padding)
        stackView.contentMode = .center
        return stackView
    }()
    var answerButtons:[UIButton] = [UIButton(), UIButton(), UIButton(), UIButton(), UIButton()]
    
    public override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    @objc func dismissTipsOptions(recognizer : UITapGestureRecognizer){
        delegate?.dismissTipsOptions(recognizer: recognizer)
    }
    @objc func showTips(_ sender: Any){
        delegate?.showTips(sender)
    }
    @objc func backtoHome(_ sender: Any){
        delegate?.backtoHome()
    }
    @objc func handleTapPress(_ sender : Any){
        delegate?.handleTapPress(sender)
    }
    @objc func showTipsOptions(_ sender: Any){
        delegate?.showTipsOptionsView()
    }
    func showTipOptionbuttons(){
        showComicTipsButton()
    }
    
    func setupAnswersContainerView() {
        
        answerButtons.forEach {
            $0.setColoredLightBorders(color: .white)
            $0.setupCornedButton(title: nil, font: .textFontLarge, cornerRadius: Constants.answersButtonHeight / 2)
            $0.addTarget(self, action: #selector(handleTapPress(_:)), for: .touchUpInside)
            $0.tag = tagAnswerButtons
            $0.isUserInteractionEnabled = true
            $0.backgroundColor = .defaultButtonColor
            self.tagAnswerButtons = self.tagAnswerButtons + 1
            
            $0.snp.makeConstraints({ (make) in
                make.height.equalTo(Constants.answersButtonHeight)
            })
            stackViewButtons.addArrangedSubview($0)
        }
        answerButtonsContainerView.addSubview(stackViewButtons)
        stackViewButtons.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    func reloadAnswerButtons(chars:Array<CharacterDataWrapper.CharacterDataContainer.Character>){
        var names:[String] = []
        
        for i in 0...chars.count - 1 {
            names.append(chars[i].name ?? "not found")
            answerButtons[i].setAttributedTitle(nil, for: .normal)
            answerButtons[i].backgroundColor = .defaultButtonColor
            answerButtons[i].isUserInteractionEnabled = true
            answerButtons[i].setTitle(chars[i].name ?? "not found", for: .normal)
        }
        self.layoutIfNeeded()
    }
    func dismissOptionsTipsContainerView(){
        dismissTipsButtons()
    }
    
    func showComicsTips(comics:Array<CharacterDataWrapper.CharacterDataContainer.Character.ComicList.ComicSummary>){
        let localizedString = NSLocalizedString("Appeared in comics", comment: "")
        self.textHint = "\(localizedString): \n"
        if comics.count != 0 {
            for i in 0...comics.count - 1 {
                self.textHint.append(contentsOf: "\(comics[i].name!) \n")
            }
        }
        tipTextView.text = self.textHint
        
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.tipsContainerView.transform = CGAffineTransform.identity
            self.tipsContainerView.alpha = 1
        })
    }
    
    func showSeriesTips(_ series:Array<CharacterDataWrapper.CharacterDataContainer.Character.SeriesList.SeriesSummary>){
        let localizedString = NSLocalizedString("Appeared in series", comment: "")
        self.textHint = "\(localizedString): \n"
        if series.count != 0 {
            for i in 0...series.count - 1 {
                self.textHint.append(contentsOf: "\(series[i].name!) \n")
            }
        }
        tipTextView.text = self.textHint
        
        tipsContainerView.bringSubviewToFront(tipTextView)
        
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.tipsContainerView.transform = CGAffineTransform.identity
            self.tipsContainerView.alpha = 1
        })
    }
    
    func showEventTips(events:Array<CharacterDataWrapper.CharacterDataContainer.Character.EventList.EventSummary>){
        
        let localizedString = NSLocalizedString("Appeared in events", comment: "")
        self.textHint = "\(localizedString): \n"
        if events.count != 0 {
            if events.count > 0 {
                for i in 0...events.count - 1 {
                    self.textHint.append(contentsOf: "\(events[i].name!) \n")
                }
            }
        }
        tipTextView.text = self.textHint
        
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.tipsContainerView.transform = CGAffineTransform.identity
            self.tipsContainerView.alpha = 1
        })
    }
    
    func removeTipsView(){
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.tipsContainerView.transform = CGAffineTransform(translationX: 0, y: 500)
            self.tipsContainerView.alpha = 0
        })
    }
    
    func playWrongAnimation(){
        wrongAnimationView.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.wrongAnimationView.stop()
        }
    }
    func playCorrectAnimation(){
        correctAnimationView.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.correctAnimationView.stop()
        }
    }
    fileprivate func setupView() {
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(dismissTipsOptions(recognizer:)))
        addGestureRecognizer(recognizer)
        
        addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        addSubview(labelScore)
        labelScore.snp.makeConstraints { (make) in
            make.topMargin.equalTo(Constants.guide)
            make.centerX.equalToSuperview()
            make.width.equalTo(Constants.scoreWidth)
            make.height.equalTo(Constants.scoreHeight)
        }
        addSubview(homeButton)
        homeButton.snp.makeConstraints { (make) in
            make.leadingMargin.equalTo(Constants.padding)
            make.centerY.equalTo(labelScore)
            make.width.equalTo(Constants.homeButtonHeight)
            make.height.equalTo(Constants.homeButtonHeight)
        }
        addSubview(helpButton)
        helpButton.snp.makeConstraints { (make) in
            make.trailingMargin.equalTo(-Constants.padding)
            make.centerY.equalTo(labelScore)
            make.width.equalTo(Constants.helpButtonRadius)
            make.height.equalTo(Constants.helpButtonRadius)
        }
        addSubview(imageViewCard)
        imageViewCard.snp.makeConstraints { (make) in
            make.top.equalTo(labelScore.snp.bottom).offset(Constants.padding * 2)
            make.trailingMargin.equalTo(-Constants.padding * 2)
            make.leadingMargin.equalTo(Constants.padding * 2)
            make.height.equalTo(Constants.imageHeight)
        }
        addSubview(bluredView)
        bluredView.snp.makeConstraints { (make) in
            make.topMargin.equalTo(imageViewCard)
            make.trailingMargin.equalTo(imageViewCard)
            make.leadingMargin.equalTo(imageViewCard)
            make.height.equalTo(imageViewCard)
        }
        //        addSubview(animatedSwitch)
        //        animatedSwitch.snp.makeConstraints { (make) in
        //            make.top.equalTo(bluredView.snp.bottom).offset(Constants.answerAnimationPadding)
        //            make.leading.equalToSuperview().offset(Constants.padding)
        //            make.width.equalTo(Constants.switchWidth)
        //            make.height.equalTo(Constants.switchHeight)
        //        }
        addSubview(wrongAnimationView)
        wrongAnimationView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(bluredView.snp.bottom).offset(Constants.answerAnimationPadding)
            make.height.equalTo(Constants.answerAnimationHeight)
            make.width.equalTo(Constants.answerAnimationHeight)
        }
        addSubview(correctAnimationView)
        correctAnimationView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(bluredView.snp.bottom).offset(Constants.answerAnimationPadding)
            make.height.equalTo(Constants.answerAnimationHeight)
            make.width.equalTo(Constants.answerAnimationHeight)
        }
        
        addSubview(labelImageTitle)
        labelImageTitle.snp.makeConstraints { (make) in
            make.top.equalTo(correctAnimationView.snp.bottom).offset(Constants.answerAnimationPadding)
            make.trailingMargin.equalTo(-Constants.padding)
            make.leadingMargin.equalTo(Constants.padding)
            make.height.equalTo(Constants.imageTitleHeight)
        }
        
        addSubview(answerButtonsContainerView)
        answerButtonsContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(labelImageTitle.snp.bottom).offset(Constants.padding)
            make.trailingMargin.equalTo(-Constants.padding)
            make.leadingMargin.equalTo(Constants.padding)
            make.bottomMargin.equalTo(-Constants.padding)
        }
        
        addSubview(tipsContainerView)
        tipsContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.labelImageTitle.snp.bottom).offset(Constants.padding)
            make.leadingMargin.equalTo(Constants.padding)
            make.trailingMargin.equalTo(-Constants.padding)
            make.bottomMargin.equalTo(-Constants.padding)
            
        }
        tipsContainerView.transform = CGAffineTransform(translationX: 0, y: 500)
        
        tipsContainerView.addSubview(tipsBackground)
        tipsBackground.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        tipsContainerView.addSubview(tipTextView)
        tipTextView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(Constants.padding)
            make.leading.equalToSuperview().offset(Constants.padding)
            make.trailing.equalToSuperview().inset(Constants.padding)
            make.bottom.equalToSuperview().inset(Constants.padding)
        }
        setupAnswersContainerView()
        setupOptionsTipsView()
    }
    func setupOptionsTipsView(){
        
        addSubview(comicTipsButton)
        comicTipsButton.snp.makeConstraints { (make) in
            make.topMargin.equalTo(Constants.guide)
            make.trailingMargin.equalTo(-Constants.padding)
            make.width.equalTo(Constants.helpButtonRadius * 2)
            make.height.equalTo(Constants.helpButtonRadius * 2)
        }
        addSubview(comicTipsLabel)
        comicTipsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(comicTipsButton.snp.bottom).offset(3)
            make.centerX.equalTo(comicTipsButton.snp.centerX)
        }
        addSubview(seriesTipsButton)
        seriesTipsButton.snp.makeConstraints { (make) in
            make.topMargin.equalTo(Constants.guide)
            make.trailingMargin.equalTo(-Constants.padding)
            make.width.equalTo(Constants.helpButtonRadius * 2)
            make.height.equalTo(Constants.helpButtonRadius * 2)
        }
        addSubview(seriesTipsLabel)
        seriesTipsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(seriesTipsButton.snp.bottom).offset(3)
            make.centerX.equalTo(seriesTipsButton.snp.centerX)
        }
        addSubview(eventsTipsButton)
        eventsTipsButton.snp.makeConstraints { (make) in
            make.topMargin.equalTo(Constants.guide)
            make.trailingMargin.equalTo(-Constants.padding)
            make.width.equalTo(Constants.helpButtonRadius * 2)
            make.height.equalTo(Constants.helpButtonRadius * 2)
        }
        addSubview(eventsTipsLabel)
        eventsTipsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(eventsTipsButton.snp.bottom).offset(3)
            make.centerX.equalTo(eventsTipsButton.snp.centerX)
        }
    }
    func showComicTipsButton(){
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.labelScore.alpha = 0
            
            self.comicTipsButton.alpha = 1
            self.seriesTipsButton.alpha = 1
            self.eventsTipsButton.alpha = 1
            
            self.comicTipsLabel.alpha = 1
            self.seriesTipsLabel.alpha = 1
            self.eventsTipsLabel.alpha = 1
            
            self.comicTipsButton.layer.transform = CATransform3DMakeScale(1.1, 1.1, 1.1)
            self.comicTipsButton.transform = CGAffineTransform(translationX: -(UIScreen.main.bounds.width - (4 * Constants.padding) - Constants.homeButtonHeight - Constants.tipsButtonsHeingt) * 0.15, y: 0)
            self.comicTipsLabel.transform = CGAffineTransform(translationX: -(UIScreen.main.bounds.width - (4 * Constants.padding) - Constants.homeButtonHeight - Constants.tipsButtonsHeingt) * 0.15, y: 0)
            
            self.seriesTipsButton.layer.transform = CATransform3DMakeScale(1.1, 1.1, 1.1)
            self.seriesTipsButton.transform = CGAffineTransform(translationX: -(UIScreen.main.bounds.width - (4 * Constants.padding) - Constants.homeButtonHeight - Constants.tipsButtonsHeingt) * 0.5, y: 0)
            self.seriesTipsLabel.transform = CGAffineTransform(translationX: -(UIScreen.main.bounds.width - (4 * Constants.padding) - Constants.homeButtonHeight - Constants.tipsButtonsHeingt) * 0.5, y: 0)
            
            self.eventsTipsButton.layer.transform = CATransform3DMakeScale(1.1, 1.1, 1.1)
            self.eventsTipsButton.transform = CGAffineTransform(translationX: -(UIScreen.main.bounds.width - (4 * Constants.padding) - Constants.homeButtonHeight - Constants.tipsButtonsHeingt) * 0.85, y: 0)
            self.eventsTipsLabel.transform = CGAffineTransform(translationX: -(UIScreen.main.bounds.width - (4 * Constants.padding) - Constants.homeButtonHeight - Constants.tipsButtonsHeingt) * 0.85, y: 0)
        })
    }
    func dismissTipsButtons()
    {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.labelScore.alpha = 1
            
            self.comicTipsButton.alpha = 0
            self.seriesTipsButton.alpha = 0
            self.eventsTipsButton.alpha = 0
            
            self.comicTipsLabel.alpha = 0
            self.seriesTipsLabel.alpha = 0
            self.eventsTipsLabel.alpha = 0
            
            self.comicTipsButton.transform = CGAffineTransform.identity
            self.comicTipsButton.layer.transform = CATransform3DIdentity
            self.comicTipsLabel.transform = CGAffineTransform.identity
            
            self.seriesTipsButton.transform = CGAffineTransform.identity
            self.seriesTipsButton.layer.transform = CATransform3DIdentity
            self.seriesTipsButton.transform = CGAffineTransform.identity
            
            self.eventsTipsButton.transform = CGAffineTransform.identity
            self.eventsTipsButton.layer.transform = CATransform3DIdentity
            self.eventsTipsButton.transform = CGAffineTransform.identity
        })
    }
    
    func setupDataView(_ character: CharacterDataWrapper.CharacterDataContainer.Character) -> Void {
        self.bluredView.alpha = 1
        
        let urlPath = "\(character.thumbnail?.path! ?? "").\(character.thumbnail?.extension! ?? "")"
        let url = URL(string: urlPath)
        let data = try? Data(contentsOf: url!)
        
        self.imageViewCard.image = UIImage(data: data!)
        self.labelImageTitle.text = "???"
        layoutIfNeeded()
    }
    
    func showAnswer(_ name:String, selectedIndex:Int, characters:Array<CharacterDataWrapper.CharacterDataContainer.Character>, currentScore:Int) -> Int {
        var score = currentScore
        
        if name == characters[selectedIndex].name {
            playCorrectAnimation()
            score = score + 5
            self.labelImageTitle.text = characters[selectedIndex].name
            let localizedString = NSLocalizedString("Score", comment: "")
            self.labelScore.text = "\(localizedString) \(score)"
            
            UIView.animate(withDuration: 2, delay: 0, options: .curveEaseInOut, animations: {
                self.bluredView.alpha = 0
            }) { (_) in
                
            }
            return score
        } else {
            playWrongAnimation()
            self.labelImageTitle.text = characters[selectedIndex].name
            let localizedString = NSLocalizedString("Score", comment: "")
            self.labelScore.text = "\(localizedString) \(score)"
            UIView.animate(withDuration: 2, delay: 0, options: .curveEaseInOut, animations: {
                self.bluredView.alpha = 0
            }) { (_) in
            }
            return score
        }
    }
}
