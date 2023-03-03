//
//  AddContactTableUtility.swift
//  TableViewList
//
//  Created by Himanshu on 3/3/23.
//

import UIKit

extension AddContactVC {
    
    func setData(_ indexPath: IndexPath, _ cell: PhoneTextField){
        if data != nil && data?.0.mobile.count == addContactCells - 1 {
            if let type = data?.0.mobile[indexPath.row].0 {
                cell.phoneTypeButton.setTitle(type, for: .normal)
            }
            if let number = data?.0.mobile[indexPath.row].1 {
                cell.phoneTextField.text = number
            }
        }
    }
    
    func setData(_ indexPath: IndexPath, _ cell: TextFieldCell) {
        if data != nil {
            switch indexPath.row{
            case 0:
                guard let name = data?.0.firstname else {
                    return
                }
                cell.textField.text = name
            case 1:
                guard let name = data?.0.lastname else {
                    return
                }
                cell.textField.text = name
            default:
                break
            }
        }
    }
    
    func setPaddingToTextField(cell: TextFieldCell) {
        let paddingView = UIView(frame: CGRectMake(0, 0, 15, cell.textField.frame.height))
        cell.textField.leftView = paddingView
        cell.textField.leftViewMode = UITextField.ViewMode.always
    }
    
    
    //method to change the button state
    //when editing is done by the user
    //in the text fields
    @objc func changeDoneButtonState() {
        for (_ , value) in textFieldsArr {
            if value.text != "" {
                doneButton.isEnabled = true
                return
            }
        }
        for value in addContactCellsArr {
            if value != nil {
                if value?.phoneTextField.text != "" {
                    doneButton.isEnabled = true
                    return
                }
            }
        }
        doneButton.isEnabled = false
    }
    
    //delete contact
    func deleteContact(indexPath: IndexPath) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Delete Contact", style: .destructive, handler: { UIAlertAction in
                    ContactCRUD.contactCRUD.deleteContact(indexPath: indexPath)
                    self.contactDetailVC?.popToRootVC()
                    self.dismiss(animated: true)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(actionSheet, animated: true)
    }
    
}
