//
//  AddTagViewController.swift
//  SmartBinder
//
//  Created by Zentaro Imai on 2021/06/04.
//

import UIKit
import RealmSwift

class AddTagViewController: UIViewController {
    
    @IBOutlet var nameTextField: UITextField!
    
    var number: Int = 0

    
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //新しい行を追加する
    @IBAction func addTag () {
        
        //データを追加するコード
        let PictureData = PictureData()
        PictureData.title = nameTextField.text!


        
        try! realm.write {
            realm.add(PictureData)
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
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
