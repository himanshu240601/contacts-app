//
//  AddContactVC.swift
//  TableViewList
//
//  Created by Himanshu on 3/2/23.
//

import UIKit

class AddContactVC: UIViewController {

    // MARK: outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: properties
    var placeholderText = ["First Name", "Last Name", "Company"]
    var textFieldsArr = [String: UITextField]()
    
    // MARK: lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: actions
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        if doneButton.isEnabled {
            let bottomAction = UIAlertController(title: nil, message: "Are you sure you want to discard this new contact?", preferredStyle: .actionSheet)
            
            bottomAction.addAction(UIAlertAction(title: "Discard Changes", style: .destructive, handler: { UIAlertAction in
                self.dismiss(animated: true)
            }))
            bottomAction.addAction(UIAlertAction(title: "Keep Editing", style: .default))
            
            present(bottomAction, animated: true)
        }
        else {
            self.dismiss(animated: true)
        }
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func addPhotoButtonTapped(_ sender: UIButton) {
        
    }
}
