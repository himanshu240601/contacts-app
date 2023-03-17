//
//  PersonInfo+CoreDataProperties.swift
//  TableViewList
//
//  Created by Himanshu on 3/15/23.
//
//

import Foundation
import CoreData


extension PersonInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonInfo> {
        return NSFetchRequest<PersonInfo>(entityName: "PersonInfo")
    }

    @NSManaged public var firstname: String?
    @NSManaged public var lastname: String?
    @NSManaged public var image: Data?
    @NSManaged public var id: UUID?
    @NSManaged public var personToContact: Set<ContactInfo>?
    
    public var contactsData: [ContactInfo] {
        let setOfContacts = personToContact
        return setOfContacts!.sorted{
            $0.id > $1.id
        }
    }

}

// MARK: Generated accessors for personToContact
extension PersonInfo {

    @objc(addPersonToContactObject:)
    @NSManaged public func addToPersonToContact(_ value: ContactInfo)

    @objc(removePersonToContactObject:)
    @NSManaged public func removeFromPersonToContact(_ value: ContactInfo)

    @objc(addPersonToContact:)
    @NSManaged public func addToPersonToContact(_ values: Set<ContactInfo>)

    @objc(removePersonToContact:)
    @NSManaged public func removeFromPersonToContact(_ values: Set<ContactInfo>)

}

extension PersonInfo : Identifiable {

}
