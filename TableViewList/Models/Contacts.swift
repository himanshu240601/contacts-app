//
//  Contacts.swift
//  TableViewList
//
//  Created by Himanshu on 2/21/23.
//

import Foundation
import UIKit

class Contacts {
    
    // MARK: properties
    var firstname: String
    var lastname: String
    var mobile: [(String, String)]
    var image: UIImage?
    
    // MARK: initializers
    init(firstname: String, lastname: String, mobile: [(String, String)], image: UIImage) {
        self.firstname = firstname
        self.lastname = lastname
        self.mobile = mobile
        self.image = image
    }
    
    // MARK: methods
    func getFullName () -> String {
        let firstName = firstname
        let lastName = lastname
        
        if firstName == "" {
            return lastName
        }else if lastName == "" {
            return firstName
        }
        return firstName + " " + lastName
    }
}
