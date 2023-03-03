//
//  SortContacts.swift
//  TableViewList
//
//  Created by Himanshu on 2/22/23.
//

import Foundation

class SortContacts {
    // MARK: instances
    static let sortContacts = SortContacts()
    
    // MARK: properties
    var sectionTitles: [String] = []
    var sortedContactList: [String: [Contacts]] = [:]
    
    // MARK: initializers
    private init() {
    }
    
    // MARK: methods
    func createSectionTitles(contactsCRUD: ContactCRUD) {
        sectionTitles = Array(Set(contactsCRUD.contactObjectsArray.compactMap(
            {
                String($0.getFullName().prefix(1)).uppercased()
            }))
        )
        sectionTitles.sort()
        
        setDataForSections(contactsCRUD: contactsCRUD)
    }
    
    func setDataForSections(contactsCRUD: ContactCRUD) {
        //initialize each
        for title in sectionTitles{
            sortedContactList[title] = [Contacts]()
        }
        
        //add data to the dictionary
        for contact in contactsCRUD.contactObjectsArray{
            sortedContactList[String(contact.getFullName().prefix(1)).uppercased()]?.append(contact)
        }
        
        //sort names in each array inside dictionary
        for (key, _) in sortedContactList {
            sortedContactList[key] = sortedContactList[key]?.sorted(by: {
                $0.getFullName().uppercased() < $1.getFullName().uppercased()
            })
        }
    }
}
