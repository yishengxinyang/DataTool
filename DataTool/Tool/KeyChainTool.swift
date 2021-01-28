//
//  KeyChainTool.swift
//  DataTool
//
//  Created by 谢祥清 on 2021/1/15.
//

import Foundation

class KeyChainTool: NSObject {
    
    static func save(account:String?, value:String){
        let query = self.queryWith(service: "DataToolBundle", account: account, value: value)
        //增、删、改、查
        let status = SecItemAdd(query as CFDictionary, nil)
        if status == errSecDuplicateItem{//该条目已存在,更新当前数据
            print("数据已存在")
            self.update(account: account, newVal: value)
            return
        }
        
        guard status == errSecSuccess else {
            print("数据保存失败")
            return
        }
        print("数据保存成功")
    }
    
    static func readData(account:String?) -> String?{
        let query = self.queryWith(service: "DataToolBundle", account: account, read: true)
        
        var result: AnyObject?
        let status = withUnsafeMutablePointer(to: &result) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        
        //校验结果
        guard status != errSecItemNotFound else {
            print("未查到相应的结果")
            return nil
        }
        guard status == noErr else {
            print("查询失败")
            return nil
        }
        
        //获取指定数据
        guard let existingItem = result as? [String : Any],
            let passwordData = existingItem[kSecValueData as String] as? Data,
            let password = String(data: passwordData, encoding: String.Encoding.utf8)
            else {
                print("未查到相应的结果")
                return nil
        }
        return password
    }
    
    static func update(account:String?, newVal:String){
        guard let valData = newVal.data(using: .utf8) else {return}
        let query = self.queryWith(service: "DataToolBundle", account: account, value: newVal)
        let attr : [String:AnyObject] = [kSecValueData as String: valData as AnyObject]
        let status = SecItemUpdate(query as CFDictionary, attr as CFDictionary)
        
        
        if status == errSecItemNotFound{//不存在相应条目，直接保存
            self.save(account: account, value: newVal)
            return
        }
        
        guard status == errSecSuccess else {
            print("条目更新失败")
            return
        }
    }
    
    static func del(account:String?){
        let query = self.queryWith(service: "DataToolBundle", account: account)
        let status = SecItemDelete(query as CFDictionary)
        
        guard status == errSecSuccess else {
            print("条目删除失败")
            return
        }
    }
    
    private static func queryWith(service:String, account:String? = nil, value:String? = nil, group:String? = nil, read:Bool = false) -> [String:Any]{
        var query:[String:Any] = [
            kSecAttrService as String:service,
            kSecClass as String:kSecClassGenericPassword,
        ]
        
        if let group = group{//应用间数据共享
            query[kSecAttrAccessGroup as String] = group
        }
        
        if let account = account{//对应账户
            query[kSecAttrAccount as String] = account
        }
        
        if let value = value?.data(using: .utf8){//保存数据
            query[kSecValueData as String] = value
        }
        
        if read{//读取数据
            query[kSecReturnData as String] = kCFBooleanTrue
            query[kSecReturnAttributes as String] = kCFBooleanTrue
        }
        
        return query
    }
}
