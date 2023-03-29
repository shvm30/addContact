//
//  Peoples+CoreDataProperties.swift
//  
//
//  Created by Владимир on 23.03.2023.
//
//

import Foundation
import CoreData


extension Peoples {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Peoples> {
        return NSFetchRequest<Peoples>(entityName: "Peoples")
    }

    @NSManaged public var name: String?
    @NSManaged public var lastname: String?
    @NSManaged public var country: String?
    @NSManaged public var birthday: String?

}
