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
    var name: String
    var mobile: [(String, String)]
    var image: UIImage?
    
    // MARK: initializers
    init(name: String, mobile: [(String, String)]) {
        self.name = name
        self.mobile = mobile
        self.image = UIImage(systemName: "person.circle.fill")
    }
}
