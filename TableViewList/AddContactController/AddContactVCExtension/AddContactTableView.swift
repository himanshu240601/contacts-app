//
//  AddContactTableView.swift
//  TableViewList
//
//  Created by Himanshu on 3/2/23.
//

import UIKit

extension AddContactVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeholderText.count
    }
    
    //set footer of sections
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude + 48
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "addPhone", for: indexPath)
            return cell
        }
        
        //if section 0
        //three text fields will be added
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "textFields", for: indexPath) as? TextFieldCell else{
            fatalError("error")
        }
        
        cell.textField.placeholder = placeholderText[indexPath.row]
    
        //set padding in the text fields
        setPaddingToTextField(cell: cell)
        
        cell.textField.addTarget(self, action: #selector(changeDoneButtonState), for: .editingChanged)
        textFieldsArr[placeholderText[indexPath.row]] = cell.textField
        
        //set values in textfields if data is not nil
        if data != nil {
            switch indexPath.row{
            case 0:
                if let name = data?.0.firstname {
                    cell.textField.text = name
                }
            case 1:
                if let name = data?.0.lastname {
                    cell.textField.text = name
                }
            default:
                break
            }
        }
        
        return cell
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
        doneButton.isEnabled = false
    }
    
}
