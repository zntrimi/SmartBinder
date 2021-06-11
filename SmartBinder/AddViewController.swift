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
    
    var number: Int = 0
    
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //新しい行を追加する
    @IBAction func addAddress () {
        
        //データを追加するコード
        let newAddress = Address()
        newAddress.name = nameTextField.text!
        
        
        try! realm.write {
            realm.add(newAddress)
        }
        
        //一個前の画面に戻る
        navigationController?.popViewController(animated: true)
        
        //進むコード
        /*  let storyboard: UIStoryboard = self.storyboard!
         
         // ②遷移先ViewControllerのインスタンス取得
         let BackToMain = storyboard.instantiateViewController(withIdentifier: "Main") as! AddressCollectionViewController
         
         // ③画面遷移
         self.show(BackToMain, sender: self) */
    }
    
    
    @IBAction func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func delete() {
        try! realm.write {
            realm.deleteAll()
        }}
    
    
    
    
}
