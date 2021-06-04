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
    @IBOutlet weak var imageView: UIImageView!

    
    
    var num = Int()
    var image: UIImage!

    
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image

    }
    
    //新しい行を追加する
    @IBAction func addTag () {
        
        let realm = try! Realm()

        
        //データを追加するコード
        let PictureData = PictureData()
        PictureData.title = nameTextField.text!


        let data = NSData(data: image.jpegData(compressionQuality: 0.9)!)
      
    
        // 写真を設定
        PictureData.data = data
        // 写真の説明を設定
      //  pictureData.title = "Test"
        // Realmにデータを書き込む
        try! realm.write {
            realm.add(PictureData)

            self.navigationController?.popViewController(animated: true)

               // ②遷移先ViewControllerのインスタンス取得

            //   self.show(goToAdd, sender: self)
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
}
