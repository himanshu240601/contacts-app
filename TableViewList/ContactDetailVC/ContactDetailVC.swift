//
//  ContactDetailVC.swift
//  TableViewList
//
//  Created by Himanshu on 2/21/23.
//

import UIKit

class ContactDetailVC: UIViewController {
    
    // MARK: outlets
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contactImageView: UIImageView!
    
    @IBOutlet weak var contactsTableView: UITableView!
    
    // MARK: properties
    var data: (Contacts, IndexPath)?
    
    
    
    // MARK: class objects
    var contactsCrud = ContactCRUD.contactCRUD
    var alertActions = AlertActions()
    var sortContacts = SortContacts.sortContacts
    
    var contactArr : [(String, String)] = []
    // MARK: lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contactArr = data?.0.mobile ?? []
        contactImageView.layer.cornerRadius = 50
        navigationItem
            .rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(openUpdateContact))
        
        setDataValues()
    }
    
    // MARK: navigate to next view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationViewController = segue.destination as? AddContactVC else {
            return
        }
        destinationViewController.hideTitle = true
    }
}
