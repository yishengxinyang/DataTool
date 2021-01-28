//
//  Car+CoreDataProperties.swift
//  
//
//  Created by 谢祥清 on 2021/1/21.
//
//

import Foundation
import CoreData


extension Car {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Car> {
        return NSFetchRequest<Car>(entityName: "Car")
    }

    @NSManaged public var id: Int32
    @NSManaged public var type: String?
    @NSManaged public var name: String?
    @NSManaged public var power: Float
    @NSManaged public var date: Int64
    @NSManaged public var owner: CarOwner?
    @NSManaged public var producer: CarProducer?

}
