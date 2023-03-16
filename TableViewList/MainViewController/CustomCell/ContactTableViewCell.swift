//
//  ContactTableViewCell.swift
//  TableViewList
//
//  Created by Nitin on 3/16/23.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    @IBOutlet weak var personImage: UIImageView!
    
    @IBOutlet weak var personContact: UILabel!
    
    func setData(image: UIImage, contact: String) {
        personImage.layer.cornerRadius = 17
        personImage.image = image
        personContact.text = contact
    }
}
