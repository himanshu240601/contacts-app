//
//  ActionAlerts.swift
//  TableViewList
//
//  Created by Himanshu on 2/21/23.
//

import UIKit

class AlertActions {
    
    let constants = Constants()
    
    // MARK: methods
    //return alert controller for deletion
    func deleteContactAlert() -> UIAlertController {
        let ac = UIAlertController(title: constants.deleteAlert, message: nil, preferredStyle: .alert)
       
        ac.addAction(UIAlertAction(title: constants.cancel, style: .default))
        
       return ac
    }
    
}
