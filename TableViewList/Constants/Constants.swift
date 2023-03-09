//
//  Constants.swift
//  TableViewList
//
//  Created by Himanshu on 3/9/23.
//

import Foundation

struct Constants {
    
    // MARK: segue identifiers
    let viewContact = "ViewContact"
    let addContact = "AddContact"
    let editContact = "EditContact"
    let labelsVC = "labelsVC"
    
    // MARK: cell identifiers
    let contact = "Contact"
    let textFields = "textFields"
    let insertPhone = "insertPhone"
    let addPhone = "addPhone"
    let deleteContact = "deleteContact"
    let labelText = "labelText"
    
    // MARK: action dialogues
    let deleteAlert = "Are You Sure?"
    let deleteTitle = "Delete"
    let delete = "Delete Contact"
    let cancel = "Cancel"
    let keepEditing = "Keep Editing"
    let discardChanges = "Discard Changes"
    let discardMessage = "Are you sure you want to discard this new contact?"
    let editTitle = "Edit"
    
    // MARK: defaults
    let defaultName = "#"
    let defaultImage = "person.circle.fill"
    let defaultMobileType = "Mobile"
    
    // MARK: error messages
    let cellDequeueError = "Error"
}
