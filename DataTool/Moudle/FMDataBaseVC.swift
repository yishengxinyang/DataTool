//
//  FMDataBaseVC.swift
//  DataTool
//
//  Created by 谢祥清 on 2021/1/20.
//

import UIKit

class FMDataBaseVC: UIViewController {
    @IBOutlet weak var nameFiled: UITextField!
    @IBOutlet weak var ageFiled: UITextField!
    @IBOutlet weak var addressFiled: UILabel!
    @IBOutlet weak var bookFiled: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func add(_ sender: Any) {
        FMDBTool.add()
    }
    
    
    @IBAction func del(_ sender: Any) {
        FMDBTool.del()
    }
    
    @IBAction func update(_ sender: Any) {
        FMDBTool.update()     
    }
    
    @IBAction func read(_ sender: Any) {
        FMDBTool.read()
    }
    
    @IBAction func readById(_ sender: Any) {
    }
    
    @IBAction func readByTerm(_ sender: Any) {
    }
    
    
    @IBAction func bacthAdd(_ sender: Any) {
    }
    
    @IBAction func batchDel(_ sender: Any) {
    }
    
    
}
