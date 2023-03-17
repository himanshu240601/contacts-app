//
//  PhoneTextFieldCell.swift
//  TableViewList
//
//  Created by Himanshu on 3/3/23.
//

import UIKit

class PhoneTextField: UITableViewCell {

    @IBOutlet weak var phoneTypeButton: UIButton!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    
    func setDataForFields(type: String, number: String) {
        phoneTypeButton.setTitle(type, for: .normal)
        phoneTextField.text = number
    }
}
