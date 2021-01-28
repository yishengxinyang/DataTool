//
//  Animal+CoreDataProperties.swift
//  
//
//  Created by 谢祥清 on 2021/1/22.
//
//

import Foundation
import CoreData


extension Animal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Animal> {
        return NSFetchRequest<Animal>(entityName: "Animal")
    }

    @NSManaged public var year: Int16
    @NSManaged public var kind: String?

}
