//
//  ContactDetailVCTableView.swift
//  TableViewList
//
//  Created by Himanshu on 3/2/23.
//

import UIKit

extension ContactDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: table view methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "contact", for: indexPath) as? TableViewContactCell else {
            fatalError("error")
        }
        
        cell.contactTypeLabel.text = contactArr[indexPath.row].0
        cell.mobileNumberLabel.text = contactArr[indexPath.row].1
        
        return cell
    }
    
    
}
