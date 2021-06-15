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
        
        
        //　ナビゲーションバーの背景色
        self.navigationController?.navigationBar.barTintColor = UIColor {_ in return #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)}
          // ナビゲーションバーのアイテムの色　（戻る　＜　とか　読み込みゲージとか）
          self.navigationController?.navigationBar.tintColor = .white
          // ナビゲーションバーのテキストを変更する
          self.navigationController?.navigationBar.titleTextAttributes = [
          // 文字の色
            
            .foregroundColor: UIColor.white]
        
        let tapGR: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
                tapGR.cancelsTouchesInView = false
                self.view.addGestureRecognizer(tapGR)
    }
    
    @objc func dismissKeyboard() {
          self.view.endEditing(true)
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
