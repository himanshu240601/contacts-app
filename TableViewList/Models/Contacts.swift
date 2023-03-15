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
    var id: UUID
    var firstname: String
    var lastname: String
    var mobile: [(String, String)]
    var image: UIImage?
    
    let constants = Constants()
    
    // MARK: initializers
    init(id: UUID, firstname: String, lastname: String, mobile: [(String, String)], image: UIImage) {
        self.id = id
        self.firstname = firstname
        self.lastname = lastname
        self.mobile = mobile
        self.image = image
    }
    
    // MARK: methods
    func getFullName () -> String {
        if firstname == "" && lastname != "" {
            return lastname
        }else if lastname == "" && firstname != "" {
            return firstname
        }
        else if firstname != "" && lastname != ""{
            return firstname + " " + lastname
        }
        return constants.defaultName
    }
}
