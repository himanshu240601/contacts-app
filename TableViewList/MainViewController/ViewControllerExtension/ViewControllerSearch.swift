//
//  ViewControllerSearch.swift
//  TableViewList
//
//  Created by Himanshu on 3/3/23.
//

import UIKit

extension ViewController{
    
    // MARK: search method
    @objc func filterData() {
        guard let text = searchController.searchBar.searchTextField.text else {
            return
        }
        
        resetData()
        
        if text != "" {
            for (key, _) in sortedContactListTemp {
                sortedContactListTemp[key] = sortedContactListTemp[key]?.filter{
                    $0.getFullName().lowercased().contains(text.lowercased())
                }
            }
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        resetData()
        tableView.reloadData()
    }
    
    func resetData() {
        sortedContactListTemp = sortContacts.sortedContactList
        sectionTitlesTemp = sortContacts.sectionTitles
    }
}
