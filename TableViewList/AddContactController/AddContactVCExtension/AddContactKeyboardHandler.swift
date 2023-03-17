//
//  AddContactKeyboardHandler.swift
//  TableViewList
//
//  Created by Himanshu on 3/17/23.
//

import UIKit

// MARK: extension for keyboard handling
extension AddContactVC: UITextFieldDelegate {
    
    func initializeHideKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        
        //to set the tap gesture recognizer in view
        view.addGestureRecognizer(tap)
        
        //to make the table view touch respond
        tap.cancelsTouchesInView = false
        
        //set the observer notifications
        setObserverNotifications()
    }
    
    //set notification for observing when keyboard is shown or hidden
    func setObserverNotifications() {
        //get the notification
        let center:NotificationCenter = NotificationCenter.default
        
        center.addObserver(self, selector: #selector(keyboardShown(notificaton:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        center.addObserver(self, selector: #selector(keyboardHidden(notificaton:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //dismiss keyboard
    @objc func dismissMyKeyboard(){
        view.endEditing(true)
    }
    
    //assing text field with value when textfield is in edit
    func textFieldDidBeginEditing(_ textField: UITextField) {
        handleKeyboardForTextField = textField
    }
    
    //handle when keyboard is shown
    @objc func keyboardShown(notificaton:Notification){
        let info:NSDictionary = notificaton.userInfo! as NSDictionary
        let keyboardSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardY = self.view.frame.height - keyboardSize.height
        let editingTextFieldY = handleKeyboardForTextField.convert(handleKeyboardForTextField.bounds, to: self.view).minY
        if self.view.frame.minY >= 0{
            if editingTextFieldY > keyboardY - 20{
                UIView.animate(withDuration: 0.25, delay: 0.0) {
                    self.view.frame = CGRect(x: 0, y: self.view.frame.origin.y - (editingTextFieldY - (keyboardY - 100)), width: self.view.bounds.width, height: self.view.bounds.height)
                }
            }
        }
    }
        
    //MARK: objc method when keyboard is hidden
    @objc func keyboardHidden(notificaton:Notification){
        UIView.animate(withDuration: 0.25, delay: 0.0) {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        }
    }
    
    //return key in keyboard
    //when clicked
    //check for next text fields and move to them
    //in the end dismiss keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    
}
