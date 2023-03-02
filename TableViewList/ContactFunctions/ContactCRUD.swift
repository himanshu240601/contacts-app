//
//  ContactCRUD.swift
//  TableViewList
//
//  Created by Himanshu on 2/21/23.
//

import Foundation
import UIKit


class ContactCRUD {
    
    // MARK: properties
    static let contactCRUD = ContactCRUD()
    let sortContacts = SortContacts.sortContacts
    var contactObjectsArray = [Contacts]()
    
    // MARK: initializers
    private init() {}
    
    // MARK: methods
    func addContact(firstname: String, lastname: String,
                    number: [(String, String)],
                    image: UIImage) {
        let contact = Contacts(firstname: firstname, lastname: lastname, mobile: number, image: image)
        contactObjectsArray.insert(contact, at: 0)
        sortContacts.createSectionTitles(contactsCRUD: ContactCRUD.contactCRUD)
    }
    
    // MARK: currently not using this function
    func deleteContact(indexPath: IndexPath) {
        let contact = sortContacts
            .sortedContactList[
                sortContacts.sectionTitles[indexPath.section]
            ]?.remove(at: indexPath.row)
        
//        removing elements from the data
//        so no element is regenerated when a new value
//        is added
//        for i in 0..<contactObjectsArray.count {
//            if (contact?.mobile.count == 0 && contactObjectsArray[i].mobile.count == 0){
//                continue
//            }
//            if (contact?.mobile[0].1 == contactObjectsArray[i].mobile[0].1 && contact?.firstname == contactObjectsArray[i].firstname) {
//                contactObjectsArray.remove(at: i)
//                break
//            }
//        }
        
//        remove entire key from sortContactList
        if sortContacts
            .sortedContactList[
                sortContacts.sectionTitles[indexPath.section]
            ]?.count == 0{

            sortContacts.sortedContactList.removeValue(forKey: sortContacts.sectionTitles[indexPath.section])
        }
    }
    
    func updateContact(
        contact: Contacts,
        firstname: String, lastname: String,
                        number: [(String, String)],
                        image: UIImage
    ) {
        contact.firstname = firstname
        contact.lastname = lastname
        contact.mobile = number
        contact.image = image

        sortContacts.createSectionTitles(contactsCRUD: ContactCRUD.contactCRUD)
    }
}
