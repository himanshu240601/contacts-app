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
    
    var constants = Constants()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // MARK: initializers
    private init() {}
    
    //fetch data from the NSManagedObject
    func getDataFromPersonInfo(data: NSManagedObject, context: NSManagedObjectContext) -> Contacts {
        //storing the values in temp variables
        let id = data.value(forKey: constants.id) as! UUID
        let firstname = data.value(forKey: constants.firstname) as! String
        let lastname = data.value(forKey: constants.lastname) as! String
        let mobile =  phoneNumbers(id: id, managedContext: context)
        let image = UIImage(data: data.value(forKey: constants.image) as! Data)!
        
        //instance to contact model class
        let contact = Contacts(
            id: id,
            firstname: firstname,
            lastname: lastname,
            mobile: mobile,
            image: image
        )
        
        return contact
    }
    
    //fetch single record
    func fetchContact(id: UUID) -> Contacts? {
        var contact: Contacts?
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: constants.personInfo)
        fetchRequest.predicate = NSPredicate(format: constants.predicateMatchID, id as CVarArg)
        do {
            let result = try context.fetch(fetchRequest)
            let data = result[0] as! NSManagedObject
            
            contact = getDataFromPersonInfo(data: data, context: context)
            
        }catch {
            print(constants.errorWhileFetch)
        }
        
        return contact
    }
    
    // fetch all the contacts data to display in the views
    func fetchContacts() {
        contactObjectsArray = []
        
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: constants.personInfo)
        
        do {
            let result = try context.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                // append values to the contactsObjectArray
                contactObjectsArray.append(getDataFromPersonInfo(data: data, context: context))
            }
            
            //finally sort the array and reload the data
            sortContacts.createSectionTitles(contactsCRUD: ContactCRUD.contactCRUD)
        }catch {
            print(constants.errorWhileFetch)
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
            print(constants.recordSaved)
            fetchContacts()
        }catch {
            print(constants.errorWhileSaving)
        }
        
    }
    
    func deleteContact(id: UUID) {
        //create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //prepare the fetch request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: constants.personInfo)
        
        fetchRequest.predicate = NSPredicate(format: constants.predicateMatchID, id as CVarArg)
        
        do {
            //get the results based on the predicate format
            let test = try managedContext.fetch(fetchRequest)
            
            let objectToDelete = test[0] as! NSManagedObject
            
            managedContext.delete(objectToDelete)
            
            do {
                try managedContext.save()
                print(constants.recordRemoved)
                fetchContacts()
            }
            catch {
                print(constants.errorWhileSaving)
            }
        }catch {
            print(constants.errorWhileRemoving)
        }
    }
    
    func updateContact(id: UUID, firstname: String, lastname: String,
                        number: [(String, String)],
                        image: UIImage
    ) {
        
        let context = appDelegate.persistentContainer.viewContext
        
        //fetch request for the personInfo
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: constants.personInfo)
        //get result based on the id
        fetchRequest.predicate = NSPredicate(format: constants.predicateMatchID, id as CVarArg)
        
        do {
            let test = try context.fetch(fetchRequest)
            
            let personInfo = test[0] as! NSManagedObject
            
            //update the values
            personInfo.setValue(firstname, forKey: constants.firstname)
            personInfo.setValue(lastname, forKey: constants.lastname)
            personInfo.setValue(image.pngData(), forKey: constants.image)

            //update the numbers
            updatePhoneNumbers(id: id, managedContext: context, numbers: number, test: test)
            
            do {
                try context.save()
                print(constants.recordUpdated)
                fetchContacts()
            }
            catch {
                print(constants.errorWhileSaving)
            }
        }catch {
            print(constants.errorWhileUpdating)
        }
    }
}
// MARK: extension for crud on Contacts Data
extension ContactCRUD {
    // fetch phone numbers from ContactInfo
    func phoneNumbers(id: UUID, managedContext: NSManagedObjectContext) -> [(String, String)] {
        
        let request: NSFetchRequest<ContactInfo> = ContactInfo.fetchRequest()
    
        request.predicate = NSPredicate(format: constants.predicateMatchID, id as CVarArg)
        var fetchedData : [ContactInfo] = []
        do {
            fetchedData = try managedContext.fetch(request)
        } catch {
            print(constants.errorWhileFetch)
        }
        
        fetchedData.sort{
            $1.value(forKey: constants.type) as! String > $0.value(forKey: constants.type) as! String
        }
        
        //an array to store mobile numbers in type [(String, Stirng)]
        var mobile: [(String, String)] = []
        
        //iterating over the mobileTemp array that contains instances to ContactInfo
        for mob in fetchedData {
            mobile.append((mob.type!, mob.contact!))
        }
        
        return mobile
    }
    
    // updatae phone numbers from ContactInfo
    func updatePhoneNumbers(id: UUID, managedContext: NSManagedObjectContext, numbers: [(String, String)], test: [NSFetchRequestResult]){

        let request: NSFetchRequest<ContactInfo> = ContactInfo.fetchRequest()
    
        request.predicate = NSPredicate(format: constants.predicateMatchID, id as CVarArg)
        
        do {
            let fetchedData = try managedContext.fetch(request)
            var contactData = fetchedData as [NSManagedObject]
            
            contactData.sort{
                $1.value(forKey: constants.type) as! String > $0.value(forKey: constants.type) as! String
            }
            
            //delete numbers
            if contactData.count > numbers.count {
                let deletions = contactData.count - numbers.count
                
                for i in numbers.count..<(numbers.count+deletions) {
                    managedContext.delete(contactData[i])
                }
            }
            
            //update the numbers
            let count = numbers.count <= contactData.count ? numbers.count : contactData.count
            for i in 0..<count {
                contactData[i].setValue(id, forKey: constants.id)
                contactData[i].setValue(numbers[i].0, forKey: constants.type)
                contactData[i].setValue(numbers[i].1, forKey: constants.cont)
            }
            
            //add numbers
            if contactData.count < numbers.count {
                let addCount = numbers.count - contactData.count
                let personInfo = test[0] as! PersonInfo
                
                for i in contactData.count..<(contactData.count+addCount) {
                    let contactInfo = ContactInfo(context: managedContext)

                    contactInfo.id = personInfo.id
                    contactInfo.type = numbers[i].0
                    contactInfo.contact = numbers[i].1

                    personInfo.addToPersonToContact(contactInfo)
                }
            }
            
        } catch {
            print(constants.errorWhileFetch)
        }
    }
}
