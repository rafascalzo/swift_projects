//
//  ImageAndVideoLibraryView.swift
//  Spacing
//
//  Created by rvsm on 11/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ImageAndVideoLibraryView: UIViewController, ImageAndVideoLibraryViewProtocol {
    
    func show(error: String) {
        showAlert(error)
    }
    
    func didFetch(data: ImageVideLibraryDataWrapper) {
        data.collection.items.forEach {
            $0.links.forEach { (link) in
                let urlString = link.href
                if let url = URL(string: urlString) {
                    self.downloadImage(from: url)
                }
            }
            
        }
    }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { [weak self] in
                self?.data.append(UIImage(data: data)!)
                self?.libraryCollectionView.reloadData()
                self?.libraryCollectionView.layoutIfNeeded()
            }
        }
    }
    func showLoading() {
        showActivityIndicator()
    }
    
    func removeLoading() {
        removeActivityIndicator()
    }
    
    var presenter: ImageAndVideoLibraryPresenterProtocol?
    var data = [UIImage]()
    let debouncer = Debouncer(timeInterval: 0.5)
    
    @IBOutlet var libraryCollectionView: UICollectionView!
    
    var searchText: String?
    var searchPublishCenter: String?
    var searchDescription:String?
    var searchDescription508: String?
    
    /*
     q (optional) string Free text search terms to compare to all indexed metadata.
     center (optional) string NASA center which published the media.
     description
     (optional)
     string Terms to search for in “Description” fields.
     description_508
     (optional)
     string Terms to search for in “508 Description” fields.
     keywords (optional) string Terms to search for in “Keywords” fields. Separate multiple values with commas.
     location (optional) string Terms to search for in “Location” fields.
     media_type
     (optional)
     string Media types to restrict the search to. Available types: [“image”, “audio”]. Separate multiple
     values with commas.
     nasa_id (optional) string The media asset’s NASA ID.
     page (optional) integer Page number, starting at 1, of results to get.
     photographer
     (optional)
     string The primary photographer’s name.
     secondary_creator
     (optional)
     string A secondary photographer/videographer’s name.
     title (optional) string Terms to search for in “Title” fields.
     year_start (optional) string The start year for results. Format: YYYY.
     year_end (optional) string The end year for results. Format: YYYY.
     */
    
    lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.delegate = self
        sc.searchResultsUpdater = self
        sc.dimsBackgroundDuringPresentation = false
        return sc
    }()
    
    func render() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        let options = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(handleOptionsTapped))
        options.tintColor = .white
        navigationItem.rightBarButtonItem = options
    }
    
    func textDidChangeRenewInterval() {
        debouncer.renewInterval()
    }
    
    @objc func handleOptionsTapped(_ action: UIAlertAction! = nil) {
        print("show options")
    }
    
    override func loadView() {
        super.loadView()
        libraryCollectionView.register(ImageAndVideoLibraryCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ImageAndVideoLibraryWireframe.createModule(viewRef: self)
        presenter?.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }
}
// MARK: UICollectionViewDelegate

extension ImageAndVideoLibraryView: UICollectionViewDelegate {
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
}

// MARK: UICollectionViewDataSource

extension ImageAndVideoLibraryView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageAndVideoLibraryCell
        cell.imageView.image = data[indexPath.item]
        return cell
    }
}

extension ImageAndVideoLibraryView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
}
extension ImageAndVideoLibraryView : UISearchResultsUpdating, UISearchControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, searchController.searchBar.text != nil, searchController.searchBar.text != "" else { return }
        print(text)
        
        textDidChangeRenewInterval()
        
        debouncer.handler = { [weak self] in
            self?.presenter?.search(text)
        }
    }
}
