//
//  RealmTool.swift
//  DataTool
//
//  Created by 谢祥清 on 2021/1/19.
//

import UIKit
import RealmSwift

class RealmTool: NSObject {
    
    var notiToken:NotificationToken?
    
    static let share:RealmTool = {
       let instance = RealmTool()
        return instance
    }()
    
    static func configRealm(){
        let dbVersion:UInt64 = 1
        guard let docPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else{return}
        let filePath = docPath.appending("/defaultDB.realm")
        
        let config = Realm.Configuration.init(fileURL: URL.init(fileURLWithPath: filePath), inMemoryIdentifier: nil, syncConfiguration: nil, encryptionKey: nil, readOnly: false, schemaVersion: dbVersion, migrationBlock: { (migration, oldVersion) in
        }, deleteRealmIfMigrationNeeded: true, shouldCompactOnLaunch: nil, objectTypes: nil)
        
        Realm.Configuration.defaultConfiguration = config
        Realm.asyncOpen { (result) in
            switch result{
            case .success:print("数据库开启成功")
            case .failure:print("数据库开启失败")
            }
        }
    }
    
    static func getDB() -> Realm?{
        guard let docPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else{return nil}
        let filePath = docPath.appending("/defaultDB.realm")
        
        guard let realm = try? Realm.init(fileURL: URL.init(fileURLWithPath: filePath)) else{return nil}
        return realm
    }
}

//MARK: - 增
extension RealmTool{
    static func add(student:Student){
        DispatchQueue.global().async {
            guard let realm = self.getDB() else {return}
            do {
                try realm.write({
                    print("线程：\(Thread.current)")
                    realm.add(student)
                })
            } catch{
                print("error = there is an error")
            }
        }
    }
    
    static func add(students:[Student]){
        DispatchQueue.global().async {
            guard let realm = self.getDB() else {return}
            do {
                try realm.write({
                    print("线程：\(Thread.current)")
                    realm.add(students)
                })
            } catch{
                print("error = there is an error")
            }
        }
    }
}

//MARK: - 删
extension RealmTool{
    static func deleteAll(){
        DispatchQueue.global().async {
            guard let realm = self.getDB() else {return}
            do {
                try realm.write({
                    print("线程：\(Thread.current)")
                    realm.deleteAll()
                })
            } catch{
                print("数据删除失败")
            }
        }
    }
    
    static func delete(students:[Student]){
        DispatchQueue.global().async {
            guard let realm = self.getDB() else {return}
            do {
                try realm.write({
                    print("线程：\(Thread.current)")
                    realm.delete(students)
                })
            } catch{
                print("数据删除失败")
            }
        }
    }
    
    static func delete(student:Student){
        DispatchQueue.global().async {
            guard let realm = self.getDB() else {return}
            do {
                try realm.write({
                    realm.delete(student)
                })
            } catch{
                print("数据删除失败")
            }
        }
    }
}

//MARK: - 改
extension RealmTool{
    static func update(student:Student?){
        DispatchQueue.global().async {
            guard let student = student else {return}
            guard let realm = self.getDB() else {return}
            do {
                try realm.write({
                    realm.add(student, update: .modified)
                })
            } catch{
                print("数据更新失败")
            }
        }
    }
}

//MARK: - 查
extension RealmTool{
    static func read() -> Results<Student>? {
        guard let realm = self.getDB() else {return nil}
        let result = realm.objects(Student.self)
        return result
    }
    
    /// 获取 指定id (主键) 的 Student
    public static func read(from id : Int) -> Student? {
        guard let realm = self.getDB() else {return nil}
        return realm.object(ofType: Student.self, forPrimaryKey: id)
    }
    
    static func read(by term:String) -> Results<Student>?{
        guard let realm = self.getDB() else {return nil}
        
        let results = realm.objects(Student.self)
        let predicate = NSPredicate.init(format: term)
        return results.filter(predicate)
    }
}

class Book: Object {
    @objc dynamic var name = ""
    @objc dynamic var author = ""
    
    /// LinkingObjects 反向表示该对象的拥有者
    let owners = LinkingObjects(fromType: Student.self, property: "books")
}


class Student: Object {
    @objc dynamic var name = ""
    @objc dynamic var age = 18
    @objc dynamic var weight = 156
    @objc dynamic var id = 0
    @objc dynamic var address = ""

    
    //重写 Object.primaryKey() 可以设置模型的主键。
    //声明主键之后，对象将被允许查询，更新速度更加高效，并且要求每个对象保持唯一性。
    //一旦带有主键的对象被添加到 Realm 之后，该对象的主键将不可修改。
    override static func primaryKey() -> String? {
        return "id"
    }
    
    //重写 Object.ignoredProperties() 可以防止 Realm 存储数据模型的某个属性
    override static func ignoredProperties() -> [String] {
        return ["tempID"]
    }
    
    //重写 Object.indexedProperties() 方法可以为数据模型中需要添加索引的属性建立索引，Realm 支持为字符串、整型、布尔值以及 Date 属性建立索引。
    override static func indexedProperties() -> [String] {
        return ["name"]
    }
    
    //List 用来表示一对多的关系：一个 Student 中拥有多个 Book。
    let books = List<Book>()
}

