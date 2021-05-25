//
//  AddViewController.swift
//  SmartBinder
//
//  Created by Zentaro Imai on 2021/05/24.
//

import UIKit
import RealmSwift


class AddViewController: UIViewController {
    
    @IBOutlet var nameTextField: UITextField!

    
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    //新しい行を追加する
    @IBAction func addAddress() {
        
        //データを追加するコード
        let newAddress = Address()
        newAddress.name = nameTextField.text!


        try! realm.write {
        realm.add(newAddress)
        }

        dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func cancel() {
        dismiss(animated: true, completion: nil)
    }
    

    

}
