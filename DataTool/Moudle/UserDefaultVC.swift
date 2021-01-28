//
//  UserDefaultVC.swift
//  DataTool
//
//  Created by 谢祥清 on 2021/1/15.
//

import UIKit

class UserDefaultVC: UIViewController {
    var userInfo = "user_api_data"
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func add(_ sender: Any) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = formatter.string(from: Date())
        self.userInfo = "user_api_data_" + date
        
        UserDefaults.standard.set(userInfo, forKey: UserDefaults.UserKey.UserInfo)
        self.getData(sender)
    }
    
    @IBAction func del(_ sender: Any) {
        UserDefaults.standard.set(nil, forKey: UserDefaults.UserKey.UserInfo)
        self.getData(sender)
    }
    
    @IBAction func update(_ sender: Any) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = formatter.string(from: Date())
        self.userInfo = "user_api_update_data" + date
        
        UserDefaults.standard.set(userInfo, forKey: UserDefaults.UserKey.UserInfo)
        self.getData(sender)
    }
    
    @IBAction func getData(_ sender: Any) {
        let info = UserDefaults.standard.string(forKey: UserDefaults.UserKey.UserInfo)
        self.label.text = "当前数值是：\(info ?? "")"
    }
}


extension UserDefaults{
    struct UserKey {
        static let UserInfo = "key_user_info"
    }
}
