//
//  AddContactImagePicker.swift
//  TableViewList
//
//  Created by Himanshu on 3/2/23.
//

import UIKit

extension AddContactVC {
    //method to handle image after selecting
    func imagePickerController(_ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else { return }
            
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
            
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
            
        imageView.image = image
        
        doneButton.isEnabled = true
            
        dismiss(animated: true)
    }
        
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
}
