//
//  RealmVC.swift
//  DataTool
//
//  Created by 谢祥清 on 2021/1/19.
//

import UIKit
import SVProgressHUD

class RealmVC: UIViewController {
    
    @IBOutlet weak var nameLab: UITextField!
    @IBOutlet weak var ageLab: UITextField!
    @IBOutlet weak var addressLabel: UITextField!
    @IBOutlet weak var booksLab: UITextField!
    
    var curStu:Student?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    @IBAction func add(_ sender: Any) {
        guard  let name = nameLab.text?.trimmingCharacters(in: .whitespaces), !name.isEmpty else{
            SVProgressHUD.showError(withStatus: "请输入名字")
            return
        }
        
        guard  let age = ageLab.text?.trimmingCharacters(in: .whitespaces), let ageVal = Int(age) else{
            SVProgressHUD.showError(withStatus: "请输入年龄")
            return
        }

        
        guard  let address = addressLabel.text?.trimmingCharacters(in: .whitespaces), !address.isEmpty else{
            SVProgressHUD.showError(withStatus: "请输入住址")
            return
        }
        
        let stu = Student()
        stu.name = name
        stu.address = address
        stu.age = ageVal
        stu.id = Int(Date().timeIntervalSince1970)
        
        RealmTool.add(student: stu)
                

    }
    
    @IBAction func del(_ sender: Any) {
        guard let student = self.curStu else {return}
        RealmTool.delete(student: student)
    }
    
    @IBAction func update(_ sender: Any) {
        guard  let name = nameLab.text?.trimmingCharacters(in: .whitespaces), !name.isEmpty else{
            SVProgressHUD.showError(withStatus: "请输入名字")
            return
        }
        
        guard  let address = addressLabel.text?.trimmingCharacters(in: .whitespaces), !address.isEmpty else{
            SVProgressHUD.showError(withStatus: "请输入住址")
            return
        }
        
        guard let stu = self.curStu else {return}
        let student = Student()
        student.name = name
        student.id = stu.id
        student.age = stu.age
        student.address = address
        
        RealmTool.update(student:student)
    }
    
    
    @IBAction func read(_ sender: Any) {
        DispatchQueue.global().async {
            guard let result = RealmTool.read(), result.count != 0 else{
                SVProgressHUD.showInfo(withStatus: "查询数据为空")
                return
            }
            
            self.curStu = result.last
            for index in 0..<result.count{
                let student = result[index]
                print("\nstudent: name = \(student.name), age = \(student.age), address = \(student.address), id = \(student.id)")
            }
        }
    }
    
    @IBAction func readByID(_ sender: Any) {
        guard let student = RealmTool.read(from: 1611047043) else{return}
        print("\nstudent: name = \(student.name), age = \(student.age), address = \(student.address), id = \(student.id)")
    }
    
    @IBAction func readByTerm(_ sender: Any) {
//        let term = "name = 'youshan'"
        let term = "name = 'youshan' AND age >= 30"
        guard let result = RealmTool.read(by: term) else{
            SVProgressHUD.showInfo(withStatus: "未查询到数据")
            return
        }
        
        for index in 0..<result.count{
            let student = result[index]
            print("\n条件查询结果：student: name = \(student.name), age = \(student.age), address = \(student.address), id = \(student.id)")
        }
    }
    
    @IBAction func batchAdd(_ sender: Any) {
        let count = 10000
        let originId = Int(Date().timeIntervalSince1970)*count
        var students = [Student]()
        for i in 0..<count{
            let student = Student()
            student.name = "xiexiangqing\(i)"
            student.address = "xiaoxintang\(i)"
            student.age = 18
            student.id = originId + i
            
            students.append(student)
        }
        
        print("开始插入\(Date())")
        RealmTool.add(students: students)
    }
    
    @IBAction func batchDel(_ sender: Any) {
        RealmTool.deleteAll()
    }
    
    

}
