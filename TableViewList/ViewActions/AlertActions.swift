//
//  ActionAlerts.swift
//  TableViewList
//
//  Created by Himanshu on 2/21/23.
//

import UIKit

class AlertActions {
    
    // MARK: methods
    //return alert controller for deletion
    func deleteContactAlert() -> UIAlertController {
       let ac = UIAlertController(title: "Are You Sure?", message: nil, preferredStyle: .alert)
       
       ac.addAction(UIAlertAction(title: "Cancel", style: .default))
        
       return ac
    }
    
}
