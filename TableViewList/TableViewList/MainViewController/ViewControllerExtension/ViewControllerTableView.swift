//
//  ViewControllerTableView.swift
//  TableViewList
//
//  Created by Himanshu on 2/22/23.
//

import UIKit

// MARK: ViewController extension for tableView functions
extension ViewController {
    
    // MARK: creating tableview sections and cells
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sortContacts.sectionTitles.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortContacts.sortedContactList[sortContacts.sectionTitles[section]]?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Contact", for: indexPath)
        
        cell.textLabel?
            .text = sortContacts.sortedContactList[sortContacts.sectionTitles[indexPath.section]]?[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = sortContacts.sortedContactList[sortContacts.sectionTitles[indexPath.section]]?[indexPath.row]
        performSegue(withIdentifier: "ViewContact", sender: (contact, indexPath))
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sortContacts.sectionTitles[section]
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        tableView.sectionIndexColor = .placeholderText
        return sortContacts.sectionTitles
    }
    
    // MARK: navigate to next view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationViewController = segue.destination as? ContactDetailVC else {
            return
        }
        destinationViewController.data = sender as? (Contacts, IndexPath)
    }
}
