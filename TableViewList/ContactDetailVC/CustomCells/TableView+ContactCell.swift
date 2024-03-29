//
//  TableView+ContactCell.swift
//  TableViewList
//
//  Created by Himanshu on 3/2/23.
//

import UIKit

class TableViewContactCell: UITableViewCell{
    
    // MARK: outlets
    @IBOutlet weak var contactTypeLabel: UILabel!
    @IBOutlet weak var mobileNumberLabel: UILabel!
    
    func setData(type: String, mobile: String){
        contactTypeLabel.text = type
        mobileNumberLabel.text = mobile
    }
}
