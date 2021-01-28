//
//  KeyChainViewController.swift
//  DataTool
//
//  Created by 谢祥清 on 2021/1/15.
//

import UIKit

class KeyChainVC: UIViewController {

    @IBOutlet weak var textFiled: UITextField!
    @IBOutlet weak var accountFiled: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func add(_ sender: Any) {
        guard let val = textFiled.text?.trimmingCharacters(in: .whitespaces), !val.isEmpty else{
            print("请输入内容")
            return
        }
        KeyChainTool.save(account: accountFiled.text, value: val)
    }
    
    @IBAction func del(_ sender: Any) {
        KeyChainTool.del(account: accountFiled.text)
    }
    
    @IBAction func update(_ sender: Any) {
        guard let val = textFiled.text?.trimmingCharacters(in: .whitespaces), !val.isEmpty else{
            print("请输入内容")
            return
        }
        KeyChainTool.update(account: accountFiled.text, newVal: val)
    }
    
    @IBAction func getData(_ sender: Any) {
        let password = KeyChainTool.readData(account: accountFiled.text)
        print("password = \(password ?? "")")
    }
    
    
}
