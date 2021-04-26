//
//  MarsRoverView.swift
//  YSpace
//
//  Created by RVSM on 25/03/20.
//  Copyright © 2020 Rafael Scalzo. All rights reserved.
//

import UIKit

class MarsRoverPhotosCell: UICollectionViewCell {
    
    var roverImage: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(roverImage)
        backgroundColor = UIColor(hue: 0.677, saturation: 0.655, brightness: 0.445, alpha: 1)
        NSLayoutConstraint.activate([
            roverImage.topAnchor.constraint(equalTo: topAnchor),
            roverImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            roverImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            roverImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private let marsRoverPhotosCellIdentifier = "MarsRoverPhotosCell"

class MarsRoverView: UICollectionViewController {
    
    var presenter: MarsRoverPresenterProtocol?
    
    var photos = [RoverPhotosObject]()
    
    override func loadView() {
        super.loadView()
        collectionView.register(MarsRoverPhotosCell.self, forCellWithReuseIdentifier: marsRoverPhotosCellIdentifier)
    }
    
    func render() {
        collectionView.backgroundColor = .white
        //presenter?.fetchByEarthDate(rover: .curiosity, camera: .fhaz, date: nil, page: 1)
        presenter?.fetchByMartianSol(rover: .opportunity, camera: nil, sol: 1000, page: 1)
    }
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MarsRoverWireframe.createModule(viewRef: self)
        presenter?.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: marsRoverPhotosCellIdentifier, for: indexPath) as! MarsRoverPhotosCell
        let selected = photos[indexPath.item]
        
        let urlString = selected.imageSource.replacingOccurrences(of: "http", with: "https")
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                let image = UIImage(data: data)
                cell.roverImage.image = image
            } else {
                cell.roverImage.image = UIImage(named: "mars_rover")
            }
        }
        return cell
    }
}

extension MarsRoverView : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 270)
    }
}

extension MarsRoverView: MarsRoverViewProtocol {
    
    func didFetch(roverPhotos: MarsRoverPhotos) {
        if let photos = roverPhotos.photos {
            print(photos.count)
            self.photos = photos
            collectionView.reloadData()
        }
    }
    
    func showError(_ message: String) {
        print(message)
    }
    
    func showLoading() {
        showActivityIndicator()
    }
    
    func removeLoading() {
        removeActivityIndicatorView()
    }
}
