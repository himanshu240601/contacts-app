//
//  ViewControllerContactMod.swift
//  TableViewList
//
//  Created by Himanshu on 2/22/23.
//

import UIKit

// MARK: ViewController extension of functions for adding, removing, updating the contact
extension ViewController {
    
    @objc func openAddNewContact() {
        performSegue(withIdentifier: constants.addContact, sender: self)
    }
}
