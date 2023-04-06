//
//  Human+CoreDataProperties.swift
//  m20
//
//  Created by Владимир on 03.04.2023.
//
//

import Foundation
import CoreData


extension Human {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Human> {
        return NSFetchRequest<Human>(entityName: "Human")
    }

    @NSManaged public var birthday: String?
    @NSManaged public var country: String?
    @NSManaged public var lastname: String?
    @NSManaged public var name: String?
    @NSManaged public var sort: String?

}

extension Human : Identifiable {

}
