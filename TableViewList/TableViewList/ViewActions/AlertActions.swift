//
//  ActionAlerts.swift
//  TableViewList
//
//  Created by Himanshu on 2/21/23.
//

import Foundation
import UIKit

class AlertActions {
    
    // MARK: methods
    
    //add text fields to alert controllers
    func addTextField(alertController: UIAlertController, position: Int, placeholder: String) {
        alertController.addTextField()
        alertController.textFields?[position].placeholder = placeholder
        alertController.textFields?[position].clearButtonMode = .whileEditing
        
        if(placeholder == "Number") {
            alertController.textFields?[position].keyboardType = .phonePad
        }
    }
    
    //return alert controller for editing contact
    func editContactAlert(name: String, number: [(String, String)]) -> UIAlertController {
        let ac = UIAlertController(title: "Update Contact", message: nil, preferredStyle: .alert)
        
        addTextField(alertController: ac, position: 0, placeholder: "Name")
//        addTextField(alertController: ac, position: 1, placeholder: "Number")
        
        //set values to textfields
        ac.textFields?[0].text = name
//        ac.textFields?[1].text = number
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        
        return ac
    }
    
    //return alert controller for deletion
    func deleteContactAlert() -> UIAlertController {
       let ac = UIAlertController(title: "Are You Sure?", message: nil, preferredStyle: .alert)
       
       ac.addAction(UIAlertAction(title: "Cancel", style: .default))
        
       return ac
    }
    
}
