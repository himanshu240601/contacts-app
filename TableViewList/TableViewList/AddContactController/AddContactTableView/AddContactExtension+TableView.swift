//
//  AddContactExtension+TableView.swift
//  TableViewList
//
//  Created by Nitin on 3/2/23.
//

import UIKit

extension AddContactVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "textFields", for: indexPath) as? TextFieldCell else {
            fatalError("error")
        }
        
        cell.textField.placeholder = placeholderText[indexPath.row]
        cell.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        textFieldsArr[placeholderText[indexPath.row]] = cell.textField
        
        return cell
    }
    
    @objc func textFieldDidChange() {
        for (_, value) in textFieldsArr {
            if value.text != "" {
                doneButton.isEnabled = true
                return
            }
        }
        doneButton.isEnabled = false
    }
}
