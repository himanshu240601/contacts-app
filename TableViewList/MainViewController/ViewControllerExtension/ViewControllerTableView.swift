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
        return sectionTitlesTemp.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedContactListTemp[sectionTitlesTemp[section]]?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: constants.contact, for: indexPath) as? ContactTableViewCell else {
            fatalError(constants.cellDequeueError)
        }
        let contact = sortedContactListTemp[sectionTitlesTemp[indexPath.section]]?[indexPath.row]
        let text = {
                if contact?.getFullName() == constants.defaultName {
                    return contact?.mobile[0].1
                }
                return contact?.getFullName()
            }()
        let image = contact?.image!
        
        cell.setData(image: image!, contact: text!)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = sortedContactListTemp[sectionTitlesTemp[indexPath.section]]?[indexPath.row]
        performSegue(withIdentifier: constants.viewContact, sender: (contact, indexPath))
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if self.tableView(tableView, numberOfRowsInSection: section) == 0{
            return nil
        }
        return sortContacts.sectionTitles[section]
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        tableView.sectionIndexColor = .placeholderText
        return sectionTitlesTemp
    }
    
    // MARK: navigate to next view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationViewController = segue.destination as? ContactDetailVC else {
            guard let destination = segue.destination as? AddContactVC else {
                return
            }
            destination.viewControllerInst = sender as? ViewController
            return
        }
        destinationViewController.data = sender as? (Contacts, IndexPath)
    }
    
}
