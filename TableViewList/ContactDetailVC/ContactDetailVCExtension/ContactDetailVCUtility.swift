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
        nameLabel.text = {
            if data?.0.getFullName() == constants.defaultName {
                return ""
            }
            return data?.0.getFullName()
        }()
        contactImageView.image = data?.0.image
        contactArr = data?.0.mobile ?? []
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
    
    func popToRootVC() {
        self.navigationController?.popViewController(animated: true)
    }
}
