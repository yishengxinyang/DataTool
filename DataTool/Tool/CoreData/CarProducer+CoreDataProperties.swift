//
//  CarProducer+CoreDataProperties.swift
//  
//
//  Created by 谢祥清 on 2021/1/21.
//
//

import Foundation
import CoreData


extension CarProducer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CarProducer> {
        return NSFetchRequest<CarProducer>(entityName: "CarProducer")
    }

    @NSManaged public var name: String?
    @NSManaged public var address: String?

}
