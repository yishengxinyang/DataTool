//
//  CarOwner+CoreDataProperties.swift
//  
//
//  Created by 谢祥清 on 2021/1/21.
//
//

import Foundation
import CoreData


extension CarOwner {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CarOwner> {
        return NSFetchRequest<CarOwner>(entityName: "CarOwner")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var address: String?

}
