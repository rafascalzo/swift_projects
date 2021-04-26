//
//  SpaceMainView.swift
//  YSpace
//
//  Created by Rafael VSM on 31/01/20.
//  Copyright © 2020 Rafael VSM. All rights reserved.
//

import UIKit

enum SceneCase {
    case PICTURE_OF_THE_DAY, MARS, EXOPLANET, IMAGE_AND_VIDEO_LIBRARY, EPIC
}

struct Scene {
    
    var title: String
    var scene: SceneCase
    var imageName: String
}

class SpaceMainCell: UITableViewCell {
    
    var backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    var title: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(backgroundImageView)
        addSubview(title)
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            title.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
private let spaceMainIdentifier = "SpaceMain"

class SpaceMainView: UITableViewController {
    
    var presenter: SpaceMainPresenterProtocol?
    
    var scenes = [Scene(title: "picture_of_the_day".localized, scene: .PICTURE_OF_THE_DAY, imageName: "apod"), Scene(title: "mars_rover".localized, scene: .MARS, imageName: "mars_rover"), Scene(title: "image_and_video_library".localized, scene: .IMAGE_AND_VIDEO_LIBRARY, imageName: "image_and_video_library"), Scene(title: "epic".localized, scene: .EPIC, imageName: "epic")]
    
    override func loadView() {
        super.loadView()
        tableView.register(SpaceMainCell.self, forCellReuseIdentifier: spaceMainIdentifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SpaceMainWireframe.createModule(viewRef: self)
        presenter?.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: spaceMainIdentifier, for: indexPath) as! SpaceMainCell
        let scene = scenes[indexPath.row]
        let shadow = NSShadow()
        shadow.shadowBlurRadius = 4
        shadow.shadowColor = UIColor.white
        shadow.shadowOffset = .zero
        let attributes:[NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 0.07, alpha: 1), .shadow: shadow, .font: UIFont.boldSystemFont(ofSize: 40)]
        let mutableText = NSMutableAttributedString(string: scene.title, attributes: attributes)
        
        cell.title.attributedText = mutableText
        
        cell.backgroundImageView.image = UIImage(named: scene.imageName)?.withRenderingMode(.alwaysOriginal)
        cell.selectionStyle = .none
        cell.backgroundColor = .purple
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.goTo(scene: scenes[indexPath.row], from: self)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scenes.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension SpaceMainView: SpaceMainViewProtocol {
    
    func render() {
        title = "home".localized
        view.backgroundColor = UIColor(hue: 0.56, saturation: 0.789, brightness: 0.870, alpha: 1)
    }
}

extension SpaceMainView {
    
}
