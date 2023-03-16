//
//  AddContactTableUtility.swift
//  TableViewList
//
//  Created by Himanshu on 3/3/23.
//

import UIKit

extension AddContactVC {
    
    func setData(_ indexPath: IndexPath, _ cell: PhoneTextField){
            if let contactInfo = contactData {
                if contactInfo.mobile.count == addContactCells - 1 {
                    
                    cell.phoneTypeButton
                        .setTitle(contactInfo.mobile[indexPath.row].0, for: .normal)
                    cell.phoneTextField
                        .text = contactInfo.mobile[indexPath.row].1
    
                }
                else {
                    cell.phoneTypeButton
                        .setTitle(constants.defaultMobileType, for: .normal)
                    cell.phoneTextField
                        .text = ""
                }
            }
    }
    
    func setData(_ indexPath: IndexPath, _ cell: TextFieldCell) {
        if let contactInfo = contactData {
                switch indexPath.row{
                case 0:
                    cell.textField.text = contactInfo.firstname
                case 1:
                    cell.textField.text = contactInfo.lastname
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
    func deleteContact(data: UUID) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: constants.delete, style: .destructive, handler: { UIAlertAction in
            ContactCRUD.contactCRUD.deleteContact(id: data)
                    self.contactDetailVC?.popToRootVC()
                    self.dismiss(animated: true)
        }))
        
        actionSheet.addAction(UIAlertAction(title: constants.cancel, style: .cancel))
        
        present(actionSheet, animated: true)
    }
    
    @objc func goToLabelsVC(sender: UIButton, forEvent event: UIEvent) {
        
        for (i, cell) in addContactCellsArr.enumerated() {
            if cell != nil && cell?.phoneTypeButton.titleLabel == sender.titleLabel {
                buttonTag = i
                break
            }
        }
        
        performSegue(withIdentifier: constants.labelsVC, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? LabelsTableViewController else{
            return
        }
        destination.addContactVC = self
    }
    
    func setContactTypeValue(_ text: String){
        addContactCellsArr[buttonTag]?.phoneTypeButton.setTitle(text, for: .normal)
        doneButton.isEnabled = true
    }
}
