//
//  LabelsTableViewController.swift
//  TableViewList
//
//  Created by Himanshu on 3/3/23.
//

import UIKit

class LabelsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: outlets
    @IBOutlet weak var labelsTableView: UITableView!
    
    // MARK: properties
    var lables = [
        "Mobile",
        "Home",
        "Work",
        "School",
        "iPhone",
        "Apple Watch",
        "Main",
        "Home Fax",
        "Work Fax",
        "Pager",
        "Other"
    ]
    var addContactVC: AddContactVC?
    
    // MARK: lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelsTableView.delegate = self
        labelsTableView.dataSource = self
    }

    // MARK: actions
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}


extension LabelsTableViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        lables.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        addContactVC?.setContactTypeValue(lables[indexPath.row])
        dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "labelText", for: indexPath)
        cell.textLabel?.text = lables[indexPath.row]
        
        return cell
    }
    
}
