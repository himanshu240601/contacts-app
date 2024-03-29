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
    var handleKeyboardForTextField: UITextField!
    
    // MARK: properties
    var placeholderText = ["First Name", "Last Name", "Company"]
    var addContactCellsArr: [PhoneTextField?] = [nil]
    var addContactCells = 1
    var textFieldsArr = [String: UITextField]()
    var buttonTag: Int = 0
    //data from previous controller (ContactDetailVC)
    //in case the previous controller is Root VC
    //then the data will be nil
    var data: (UUID, IndexPath)?
    var contactData: Contacts?
    var contactDetailVC: ContactDetailVC?
    var viewControllerInst: ViewController?
    let constants = Constants()
    
    // MARK: lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeHideKeyboard()
        
        //corner radius for contact image
        imageView.layer.cornerRadius = 50
        
        //change text of 'Add Photo' button
        //if the image is not default
        if let id = data?.0 {
            if let contactResult = ContactCRUD.contactCRUD.fetchContact(id: id){
                contactData = contactResult
            }
            
            if let contactInfo = contactData {
                if contactInfo.image != UIImage(systemName: constants.defaultImage) {
                    addImageButton.setTitle(constants.editTitle, for: .normal)
                    imageView.image = contactInfo.image
                }
                addContactCells += contactInfo.mobile.count
            }
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
            let bottomAction = UIAlertController(title: nil, message: constants.discardMessage, preferredStyle: .actionSheet)
            
            bottomAction.addAction(UIAlertAction(title: constants.discardChanges, style: .destructive, handler: { UIAlertAction in
                self.dismiss(animated: true)
            }))
            bottomAction.addAction(UIAlertAction(title: constants.keepEditing, style: .default))
            
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
                .updateContact(id: data ,firstname: firstName, lastname: lastName, number: number, image: image!)
            
            if let update = contactDetailVC?.data?.0 {
                update.firstname = firstName
                update.lastname = lastName
                update.mobile = number.sorted{
                    $1.0 > $0.0
                }
                update.image = image!
            }
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
