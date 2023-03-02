//
//  ViewController.swift
//  TableViewList
//
//  Created by Himanshu on 2/21/23.
//

import UIKit

class ViewController: UITableViewController {
    
    // MARK: class objects
    var staticData = StaticData()
    var contactsCrud = ContactCRUD.contactCRUD
    var alertActions = AlertActions()
    var sortContacts = SortContacts.sortContacts
    
    // MARK: lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem
            .rightBarButtonItem =
        UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openAddNewContact))
        
        //generate random data
        staticData.generateDummyData(contactsCrud: contactsCrud)
        
        sortContacts.createSectionTitles(contactsCRUD: contactsCrud)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
}
