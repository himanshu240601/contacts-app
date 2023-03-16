//
//  ContactCRUD.swift
//  TableViewList
//
//  Created by Himanshu on 2/21/23.
//

import Foundation
import UIKit
import CoreData


class ContactCRUD {
    
    // MARK: properties
    static let contactCRUD = ContactCRUD()
    let sortContacts = SortContacts.sortContacts
    var contactObjectsArray = [Contacts]()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // MARK: initializers
    private init() {}
    
    // fetch phone numbers from ContactInfo
    func phoneNumbers(id: UUID, managedContext: NSManagedObjectContext) -> [ContactInfo] {
        
        let request: NSFetchRequest<ContactInfo> = ContactInfo.fetchRequest()
    
        request.predicate = NSPredicate(format: "id = %@", id as CVarArg)
        var fetchedData : [ContactInfo] = []
        do {
            fetchedData = try managedContext.fetch(request)
        } catch let error {
            print("Error fetching songs \(error)")
        }
        
        fetchedData.sort{
            $1.value(forKey: "type") as! String > $0.value(forKey: "type") as! String
        }
        
        return fetchedData
    }
    
    // updatae phone numbers from ContactInfo
    func updatePhoneNumbers(id: UUID, managedContext: NSManagedObjectContext, numbers: [(String, String)], test: [NSFetchRequestResult]){
        var numbersArr = numbers
        let request: NSFetchRequest<ContactInfo> = ContactInfo.fetchRequest()
    
        request.predicate = NSPredicate(format: "id = %@", id as CVarArg)
        
        do {
            let fetchedData = try managedContext.fetch(request)
            var contactData = fetchedData as [NSManagedObject]
            
            contactData.sort{
                $1.value(forKey: "type") as! String > $0.value(forKey: "type") as! String
            }
            numbersArr.sort{
                $1.0 > $0.0
            }
            
            //update the numbers
            let count = numbersArr.count < contactData.count ? numbersArr.count : contactData.count
            for i in 0..<count {
                contactData[i].setValue(id, forKey: "id")
                contactData[i].setValue(numbersArr[i].0, forKey: "type")
                contactData[i].setValue(numbersArr[i].1, forKey: "contact")
            }
            
            //delete numbers
            if contactData.count > numbersArr.count {
                let deletions = contactData.count - numbersArr.count
                
                for i in numbersArr.count..<(numbersArr.count+deletions) {
                    managedContext.delete(contactData[i])
                }
            }
            
            //add numbers
            if contactData.count < numbersArr.count {
                let addCount = numbersArr.count - contactData.count
                let personInfo = test[0] as! PersonInfo
                
                for i in contactData.count..<(contactData.count+addCount) {
                    let contactInfo = ContactInfo(context: managedContext)

                    contactInfo.id = personInfo.id
                    contactInfo.type = numbers[i].0
                    contactInfo.contact = numbers[i].1

                    personInfo.addToPersonToContact(contactInfo)
                }
            }
            
        } catch let error {
            print("Error Fetching Contacts \(error)")
        }
    }
    
    func fetchContact(id: UUID) -> Contacts? {
        var contact: Contacts?
        
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PersonInfo")
        fetchRequest.predicate = NSPredicate(format: "id = %@", id as CVarArg)
        do {
            let result = try context.fetch(fetchRequest)
            let data = result[0] as! NSManagedObject
            
            let id = data.value(forKey: "id") as! UUID
            let firstname = data.value(forKey: "firstname") as! String
            let lastname = data.value(forKey: "lastname") as! String
            let mobileTemp =  phoneNumbers(id: id, managedContext: context)
            let image = UIImage(data: data.value(forKey: "image") as! Data)!
            
            //an array to store mobile numbers in type [(String, Stirng)]
            var mobile: [(String, String)] = []
            
            //iterating over the mobileTemp array that contains instances to ContactInfo
            for mob in mobileTemp {
                mobile.append((mob.type!, mob.contact!))
            }
            
            //instance to contact model class
            contact = Contacts(
                id: id,
                firstname: firstname,
                lastname: lastname,
                mobile: mobile,
                image: image
            )
        }catch {
            print("Failed")
        }
        
        return contact
    }
    
    // fetch all the contacts data to dislplay in the views
    func fetchContacts() {
        contactObjectsArray = []
        
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PersonInfo")
        
        do {
            let result = try context.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                //storing the values in temp variables
                let id = data.value(forKey: "id") as! UUID
                let firstname = data.value(forKey: "firstname") as! String
                let lastname = data.value(forKey: "lastname") as! String
                let mobileTemp =  phoneNumbers(id: id, managedContext: context)
                let image = UIImage(data: data.value(forKey: "image") as! Data)!
                
                //an array to store mobile numbers in type [(String, Stirng)]
                var mobile: [(String, String)] = []
                
                //iterating over the mobileTemp array that contains instances to ContactInfo
                for mob in mobileTemp {
                    mobile.append((mob.type!, mob.contact!))
                }
                
                //instance to contact model class
                let contact = Contacts(
                    id: id,
                    firstname: firstname,
                    lastname: lastname,
                    mobile: mobile,
                    image: image
                )
                // append values to the contactsObjectArray
                contactObjectsArray.append(contact)
            }
            
            //finally sort the array and reload the data
            sortContacts.createSectionTitles(contactsCRUD: ContactCRUD.contactCRUD)
        }catch {
            print("Failed")
        }
    }
    
    // MARK: methods
    func addContact(firstname: String, lastname: String,
                    number: [(String, String)],
                    image: UIImage) {
        let context = appDelegate.persistentContainer.viewContext
        
        //instance of personInfo to set the properties
        let personInfo = PersonInfo(context: context)
        personInfo.id = UUID()
        personInfo.firstname = firstname
        personInfo.lastname = lastname
        personInfo.image = image.pngData()
        
        //getting the contacts from [(String, String)] type array and storing in contactInfo
        //that gets added to the personInfo's relation personToContact
        for num in number {
            let contactInfo = ContactInfo(context: context)
            
            contactInfo.id = personInfo.id
            contactInfo.type = num.0
            contactInfo.contact = num.1
            
            personInfo.addToPersonToContact(contactInfo)
        }
        
        do {
            try context.save()
            print("Contact Saved")
            fetchContacts()
        }catch {
            print("Error Saving Contact")
        }
        
    }
    
    func deleteContact(id: UUID) {
        //create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //prepare the fetch request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PersonInfo")
        
        fetchRequest.predicate = NSPredicate(format: "id = %@", id as CVarArg)
        
        do {
            //get the results based on the predicate format
            let test = try managedContext.fetch(fetchRequest)
            
            let objectToDelete = test[0] as! NSManagedObject
            
            managedContext.delete(objectToDelete)
            
            do {
                try managedContext.save()
                print("Contact Removed")
                fetchContacts()
            }
            catch {
                print(error)
            }
        }catch {
            print(error)
        }
    }
    
    func updateContact(id: UUID, firstname: String, lastname: String,
                        number: [(String, String)],
                        image: UIImage
    ) {
        
        let context = appDelegate.persistentContainer.viewContext
        
        //fetch request for the personInfo
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PersonInfo")
        //get result based on the id
        fetchRequest.predicate = NSPredicate(format: "id = %@", id as CVarArg)
        
        do {
            let test = try context.fetch(fetchRequest)
            
            let personInfo = test[0] as! NSManagedObject
            
            //update the values
            personInfo.setValue(firstname, forKey: "firstname")
            personInfo.setValue(lastname, forKey: "lastname")
            personInfo.setValue(image.pngData(), forKey: "image")

            //update the numbers
            updatePhoneNumbers(id: id, managedContext: context, numbers: number, test: test)
            
            do {
                try context.save()
                print("Contact Updated")
                fetchContacts()
            }
            catch {
                print("Couldn't Update Contact")
            }
        }catch {
            print("Error Updating Contact")
        }
    }
}
