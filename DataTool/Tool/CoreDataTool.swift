//
//  CoreDataTool.swift
//  DataTool
//
//  Created by 谢祥清 on 2021/1/21.
//

import UIKit
import CoreData

/**
 参考资料（苹果官网）
 1.建立数据模型（https://developer.apple.com/documentation/coredata/creating_a_core_data_model）
 2.设置核心数据堆栈（https://developer.apple.com/documentation/coredata/setting_up_a_core_data_stack）
 2.1核心数据堆栈（https://developer.apple.com/documentation/coredata/core_data_stack）
 */

class CoreDataTool: NSObject {
    
    static func add(age:Int16, power:Float){
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = delegate.persistentContainer.viewContext
        guard let carEntity = NSEntityDescription.entity(forEntityName: "Car", in: context) else{return}
        let car = Car.init(entity: carEntity, insertInto: context)
        
        car.name = "卡罗拉"
        car.date = Int64(Date().timeIntervalSince1970)
        car.type = "混动"
        car.power = power
        car.id = 12345678
        
        guard let ownerEntity = NSEntityDescription.entity(forEntityName: "CarOwner", in: context) else{return}
        let owner = CarOwner.init(entity: ownerEntity, insertInto: context)
        owner.name = "xiexiangqing"
        owner.address = "xiaoxintang"
        owner.age = age
        car.owner = owner
        
        
        guard let producerEntity = NSEntityDescription.entity(forEntityName: "CarProducer", in: context) else{return}
        let producer = CarProducer.init(entity: producerEntity, insertInto: context)
        producer.name = "广汽丰田"
        producer.address = "广汽丰田总部"
        car.producer = producer
        
        do {
            try context.save()
            print("数据保存成功")
        } catch{
            print("数据保存失败")
        }
    }
    
    static func read(predicate:String? = nil){
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = delegate.persistentContainer.viewContext
        do{
            let request:NSFetchRequest<Car> = Car.fetchRequest()
            let sort = NSSortDescriptor.init(key: "id", ascending: true)
            request.sortDescriptors = [sort]
            if let pre = predicate{
                request.predicate = NSPredicate.init(format: pre)
            }
            let cars = try context.fetch(request)
            
            print("\n===============开始读取数据================")
            for car in cars{
                print("car.name = \(car.name ?? ""); car.power = \(car.power); car.owner.name = \(car.owner?.name ?? ""); car.owner.age = \(car.owner?.age ?? 0); car.pruducer.address = \(car.producer?.address ?? "")")
            }
            print("=================数据读取完成==================\n")
        }catch{
            print("数据读取失败")
        }
    }
    
    static func testAdd(){
        let context = CoreDataManager.share.container.viewContext
        guard let animalEntity = NSEntityDescription.entity(forEntityName: "Animal", in: context) else {return}
        let animal = Animal.init(entity:animalEntity, insertInto:context)
        animal.kind = "duck"
        animal.year = 12
        
        do {
            try context.save()
            print("数据保存成功")
        } catch(let err){
            print("数据保存失败 = \(err.localizedDescription)")
        }
    }
    
    static func update(){
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = delegate.persistentContainer.viewContext
        
        do{
            let request:NSFetchRequest<Car> = Car.fetchRequest()
            let sort = NSSortDescriptor.init(key: "id", ascending: true)
            request.sortDescriptors = [sort]
            request.predicate = NSPredicate.init(format: "power >= 2.0")
            let cars = try context.fetch(request)
            for car in cars{
                car.owner?.name = "yangpeicheng"
            }
            try? context.save()
        }catch{
            print("数据读取失败")
        }
    }
    
    static func del(predicate:String? = nil){
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = delegate.persistentContainer.viewContext
        
        do{
            let request:NSFetchRequest<Car> = Car.fetchRequest()
            let sort = NSSortDescriptor.init(key: "id", ascending: true)
            request.sortDescriptors = [sort]
            if let pre = predicate{
                request.predicate = NSPredicate.init(format: pre)
            }
            
            //将查询到的数据删除
            let cars = try context.fetch(request)
            for car in cars{
                context.delete(car)
            }
            
            try? context.save()
        }catch{
            print("数据读取失败")
        }
    }

}
