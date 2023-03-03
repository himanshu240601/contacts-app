//
//  AddContactVC.swift
//  TableViewList
//
//  Created by Himanshu on 3/2/23.
//

import UIKit

class AddContactVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    // MARK: outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var addImageButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var hideTitle: Bool = false
    
    // MARK: properties
    var placeholderText = ["First Name", "Last Name", "Company"]
    var addContactCellsArr: [PhoneTextField?] = [nil]
    var addContactCells = 1
    var textFieldsArr = [String: UITextField]()
    var buttonTag: Int = 0
    //data from previous controller (ContactDetailVC)
    //in case the previous controller is Root VC
    //then the data will be nil
    var data: (Contacts, IndexPath)?
    var contactDetailVC: ContactDetailVC?
    var viewControllerInst: ViewController?
    
    
    // MARK: lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //corner radius for contact image
        imageView.layer.cornerRadius = 50
        
        //change text of 'Add Photo' button
        //if the image is not default
        if data != nil {
            if data?.0.image != UIImage(systemName: "person.circle.fill") {
                addImageButton.setTitle("Edit", for: .normal)
                imageView.image = data?.0.image
            }
            addContactCells += data?.0.mobile.count ?? 0
        }
        
        //hide title if previous view controller is ContactDetailVC
        //note - It's opened for editing not adding new contact
        if hideTitle {
            titleLabel.isHidden = true
        }
        tableView.isEditing = true
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
        let firstName = textFieldsArr[placeholderText[0]]?.text ?? ""
        let lastName = textFieldsArr[placeholderText[1]]?.text ?? ""
        let image = imageView.image
        let number = getPhoneNumbers()
        
        if let data = data?.0 {
            ContactCRUD
                .contactCRUD
                .updateContact(contact: data, firstname: firstName, lastname: lastName, number: number, image: image!)
        }
        else if viewControllerInst != nil {
            ContactCRUD
                .contactCRUD
                .addContact(firstname: firstName, lastname: lastName, number: number, image: image!)
            
            viewControllerInst?.resetData()
            
            viewControllerInst?.tableView.reloadData()
        }
        
        dismiss(animated: true)
    }
    
    @IBAction func addPhotoButtonTapped(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    //get phone numbers from dynamically generated
    //cell in the table view
    func getPhoneNumbers() -> [(String, String)] {
        var numbersArr: [(String, String)] = []
        
        for cells in addContactCellsArr {
            if let type = cells?.phoneTypeButton.titleLabel?.text {
                if let number = cells?.phoneTextField?.text {
                    if number != "" {
                        numbersArr.append((type, number))
                    }
                }
            }
        }
        
        return numbersArr
    }
}
