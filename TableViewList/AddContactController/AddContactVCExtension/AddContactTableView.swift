//
//  AddContactTableView.swift
//  TableViewList
//
//  Created by Himanshu on 3/2/23.
//

import UIKit

extension AddContactVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // data will be nil when adding a new contact
        // if not nil the viewcontroller is opened for editing
        // return 3 to show delete at the last of the table
        if data != nil {
            return 3
        }
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //section 2 - for delete button
        //section 1 - for adding phone number
        //section 0 - for adding name, and company
        if section == 2 {
            return 1
        }
        else if section == 1 {
            return addContactCells
        }
        return placeholderText.count
    }
    
    //set footer of sections
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude + 34
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            if let data = data?.0{
                deleteContact(data: data)
            }
        }
        
        else if tableView.cellForRow(at: indexPath)?.reuseIdentifier == constants.addPhone {
            
            addContactCells += 1
            
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: [IndexPath.init(row: 0, section: 1)], with: .automatic)
            self.tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //create delete button in section 2nd (i.e. the last section)
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: constants.deleteContact, for: indexPath)
            return cell
        }
        
        //if section == 1 then show
        //one cell to add phone
        //which will remain at bottom
        if indexPath.section == 1 && (addContactCells == 1 || indexPath.row == addContactCells - 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: constants.addPhone, for: indexPath)
            return cell
        }
        //this will run when the cell   with addPhoneIdentifier is clicked
        //adds phone text fields in the section where person can add the numbers
        else if indexPath.section == 1 && indexPath.row < addContactCellsArr.count {
            // get the cell as PhoneTextField
            guard let cell = tableView.dequeueReusableCell(withIdentifier: constants.insertPhone, for: indexPath) as? PhoneTextField else {
                fatalError(constants.cellDequeueError)
            }
            cell.phoneTextField.keyboardType = .phonePad
            cell.phoneTextField.delegate = self
            cell.phoneTextField.addTarget(self, action: #selector(changeDoneButtonState), for: .editingChanged)
            cell.phoneTypeButton.addTarget(self, action: #selector(goToLabelsVC), for: .touchUpInside)
            
            addContactCellsArr.insert(cell, at: 0)
            
            setData(indexPath, cell)
            
            return cell
        }
        
        //default will remain same for section 0th
        //if section 0
        //three text fields will be added
        guard let cell = tableView.dequeueReusableCell(withIdentifier: constants.textFields, for: indexPath) as? TextFieldCell else{
            fatalError(constants.cellDequeueError)
        }
        
        cell.textField.placeholder = placeholderText[indexPath.row]
        cell.textField.delegate = self
    
        //set padding in the text fields
        setPaddingToTextField(cell: cell)
        
        cell.textField.addTarget(self, action: #selector(changeDoneButtonState), for: .editingChanged)
        textFieldsArr[placeholderText[indexPath.row]] = cell.textField
        
        //set values in textfields if data is not nil
        setData(indexPath, cell)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 1{
            if  addContactCells == 1 || indexPath.row == addContactCells - 1 {
                return false
            }
            return true
        }
        return false
    }
  
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            addContactCells -= 1
            
            let cell = tableView.cellForRow(at: indexPath) as? PhoneTextField
            
            let numberDel = cell?.phoneTextField.text
            let typeDel = cell?.phoneTypeButton.titleLabel?.text
            
            
            //remove number
            for (i, value) in addContactCellsArr.enumerated() {
                
                let type = value?.phoneTypeButton.titleLabel?.text
                let contact = value?.phoneTextField.text
                
                if (type == typeDel && contact == numberDel){
                    
                    addContactCellsArr.remove(at: i)
                    break
                    
                }
            }
            
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            
            if let contactInfo = contactData {
                if contactInfo.mobile.count > 0 {
                    var number = getPhoneNumbers()
                    
                    //remove number
                    for (i, value) in number.enumerated() {
                        if (value.0 == typeDel && value.1 == numberDel){
                            number.remove(at: i)
                            break
                        }
                    }
                    contactInfo.mobile = number
                }
            }
            
            changeDoneButtonState()
        }
    }
    
}
