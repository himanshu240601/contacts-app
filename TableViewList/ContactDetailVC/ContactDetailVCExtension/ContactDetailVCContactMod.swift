//
//  ContactDetailVCContactMod.swift
//  TableViewList
//
//  Created by Himanshu on 2/22/23.
//

import Foundation
import UIKit

// MARK: extension for ContactDetailVC contact functions update, deleted
extension ContactDetailVC {
    
    // MARK: methods
    
    //update contact
    @objc func openUpdateContact() {
        performSegue(withIdentifier: constants.editContact, sender: nil)
    }
    
}
