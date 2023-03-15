//
//  ViewController.swift
//  TableViewList
//
//  Created by Himanshu on 2/21/23.
//

import UIKit

class ViewController: UITableViewController, UISearchBarDelegate {
    
    // MARK: class objects
    let contactsCrud = ContactCRUD.contactCRUD
    let alertActions = AlertActions()
    let sortContacts = SortContacts.sortContacts
    
    let searchController = UISearchController()
    
    // MARK: properties
    var sortedContactListTemp: [String: [Contacts]] = [:]
    var sectionTitlesTemp: [String] = []
    let constants = Constants()
    
    // MARK: lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem
            .rightBarButtonItem =
        UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openAddNewContact))
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.searchTextField.addTarget(self, action: #selector(filterData), for: .editingChanged)
        searchController.searchBar.delegate = self
        
        contactsCrud.fetchContacts()
        
        resetData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        resetData()
        tableView.reloadData()
    }
}
