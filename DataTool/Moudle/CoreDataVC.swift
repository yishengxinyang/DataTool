//
//  CoreDataVC.swift
//  DataTool
//
//  Created by 谢祥清 on 2021/1/21.
//

import UIKit

class CoreDataVC: UIViewController {

    @IBOutlet weak var ageFiled: UITextField!
    @IBOutlet weak var powerFiled: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func add(_ sender: Any) {
        let age = Int16(ageFiled.text ?? "") ?? 0
        let power = Float(powerFiled.text ?? "") ?? 0.0
        CoreDataTool.add(age:age,power:power)
    }
    
    @IBAction func del(_ sender: Any) {
        CoreDataTool.del(predicate: "power >= 2.5 and owner.age < 30")
    }
    
    @IBAction func update(_ sender: Any) {
        CoreDataTool.update()
    }
    
    @IBAction func read(_ sender: Any) {
        CoreDataTool.read()
    }
    
    @IBAction func readByTerm(_ sender: Any) {
        CoreDataTool.read(predicate:"power >= 2.0 AND owner.age > 25")
    }
    
    @IBAction func deleteAll(_ sender: Any) {
        CoreDataTool.del()
    }
    
    
}
