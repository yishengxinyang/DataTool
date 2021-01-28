//
//  FMDBTool.swift
//  DataTool
//
//  Created by 谢祥清 on 2021/1/20.
//

import UIKit
import FMDB

class FMDBTool:NSObject {
    var database:FMDatabase?
    static let share:FMDBTool = {
        let instance = FMDBTool()
        return instance
    }()
    
    
    
    static func getDB() -> FMDatabase?{
        if let db = FMDBTool.share.database{
            if !db.isOpen{
                db.open()
            }
            return db
        }
        
        guard let filePath = self.getDBPath() else{return nil}
        let database = FMDatabase.init(path: filePath)
        let sql = "create table if not exists t_student ('ID' INTEGER PRIMARY KEY AUTOINCREMENT,'name' TEXT NOT NULL, 'address' TEXT NOT NULL,'age' INTEGER NOT NULL)"
        database.open()
        database.executeStatements(sql)
        FMDBTool.share.database = database
        return database
    }
    
    private static func getDBPath() -> String?{
        guard let docPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else{return nil}
        let filePath = docPath.appending("/test.db")
        print("filePath:\(filePath)")
        
        if !FileManager.default.fileExists(atPath: filePath){
            FileManager.default.createFile(atPath: filePath, contents: nil, attributes: nil)
        }
        
        return filePath

    }

}

//MARK: - 增
extension FMDBTool{
    static func add(){
        guard let database = self.getDB() else{return}
        let sql = "insert into 't_student'(ID,name,age,address) values(?,?,?,?)"
        let itemId = Int(Date().timeIntervalSince1970)
        let result = database.executeUpdate(sql, withArgumentsIn: [itemId,"xiexiangqing",29, "xiaoxintang"])
        print("result:\(result ? "插入成功" : "插入失败")")
    }
    
    static func read(){
        guard let database = self.getDB() else{return}
        let sql = "select * from 't_student' WHERE name='xiexiangqing'"
        guard let result = try? database.executeQuery(sql, values: nil) else{
            print("数据查询失败")
            return
        }
        
        
        if result.next(){
            let name = result.string(forColumn: "name")
            let age = result.long(forColumn: "age")
            let address = result.string(forColumn: "address")
            print("result: name = \(name ?? ""); age = \(age); address = \(address ?? "")")
        }
        
    }
    
    static func del(){
        guard let database = self.getDB() else{return}
        let sql = "delete from 't_student' WHERE name='xiexiangqing'"
        
        let result = database.executeStatements(sql)
        print("result:\(result ? "删除数据成功" : "删除数据失败")")
    }
    
    static func update(){
        guard let database = self.getDB() else{return}
        let sql = "update 't_student' set age = 28 WHERE name='xiexiangqing'"
        
        let result = database.executeStatements(sql)
        print("result:\(result ? "数据更新成功" : "数据更新失败")")
    }
}
