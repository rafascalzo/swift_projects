//
//  UIView+setHBFLayout.swift
//  Cep
//
//  Created by rafaeldelegate on 6/22/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import Foundation
import UIKit
extension CepViewController : UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if (tableView == self.tableViewUF){
            let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: ufCellId)
            var uF:String?
            if isSearchingUF {
                uF = filteredUfArray[indexPath.row]
            }else{
                uF = ufArray[indexPath.row]
            }
            cell.textLabel?.text = uF
            return cell
        }else {
            let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: cellId)
            var cities:String?
            if isSearchingCity {
                cities = filteredCitiesArray[indexPath.row]
            }else{
                cities = citiesArray[indexPath.row]
            }
            cell.textLabel?.text = cities
            return cell
        }
   
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (tableView == self.tableViewCity){
            if isSearchingCity {
                return filteredCitiesArray.count
            }else{
                return citiesArray.count
            }
        } else {
            if isSearchingUF {
                return filteredUfArray.count
            }else{
                return ufArray.count
            }
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("did select:      \(indexPath.row)  ")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if (searchBar == self.searchBarCity){
            if searchBarCity.text == nil || searchBarCity.text == ""{
                isSearchingCity = false
                view.endEditing(true)
                tableViewCity.reloadData()
            }else{
                isSearchingCity = true
                filteredCitiesArray = citiesArray.filter({$0.range(of: searchBarCity.text! , options : .caseInsensitive) != nil})
                tableViewCity.reloadData()
            }
        } else {
            if searchBarUF.text == nil || searchBarUF.text == ""{
                isSearchingUF = false
                view.endEditing(true)
                tableViewUF.reloadData()
            }else{
                isSearchingUF = true
                filteredUfArray = ufArray.filter({$0.range(of: searchBarUF.text! , options : .caseInsensitive) != nil})
                tableViewUF.reloadData()
            }
        }
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if searchBar == self.searchBarUF{
            tableViewUF.alpha = 1
        }else{
             tableViewCity.alpha = 1
        }
  }    
}
