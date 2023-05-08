//
//  Person+CoreDataProperties.swift
//  FaceIt
//
//  Created by Melody Davis on 4/27/23.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var imageFile: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    
    var wrappedFirstName: String {
        firstName ?? ""
    }
    
    var wrappedLastName: String {
        lastName ?? ""
    }
    
    var wrappedImageFile: String {
        imageFile ?? ""
    }

}

extension Person : Identifiable {

}
