//
//  ContactDetailVCUtility.swift
//  TableViewList
//
//  Created by Himanshu on 2/22/23.
//

import Foundation

// MARK: contact details utility extension
extension ContactDetailVC {
    
    // MARK: methods
    
    //set values in of name and text
    func setDataValues() {
        nameLabel.text = data?.0.getFullName()
        contactImageView.image = data?.0.image
        toggleButtons(checkMobileNumber())
    }
    
    //check if mobil number is valid
    func checkMobileNumber() -> Bool {
        if contactArr.isEmpty { return false }
        
        return true
    }
    
    //toggle buttons (enabled, disabled)
    func toggleButtons(_ enabled: Bool) {
        callButton.isEnabled = enabled
        messageButton.isEnabled = enabled
        emailButton.isEnabled = enabled
    }
}
