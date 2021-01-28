//
//  CoreDataManager.swift
//  DataTool
//
//  Created by 谢祥清 on 2021/1/21.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    static let share:CoreDataManager = {
        let instance = CoreDataManager()
        return instance
    }()
    
    lazy var container:NSPersistentContainer = {
        let container = NSPersistentContainer.init(name: "HomeModel")
        
        let defaultDirectoryURL = NSPersistentContainer.defaultDirectoryURL()
        let carStoreUrl = defaultDirectoryURL.appendingPathComponent("animal.sqlite")
        let storeDescription = NSPersistentStoreDescription.init(url: carStoreUrl)
        storeDescription.configuration = "Animal"
        
        container.persistentStoreDescriptions = [storeDescription]
        container.loadPersistentStores { (des, error) in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
}
