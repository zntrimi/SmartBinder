//
//  GalleryViewController.swift
//  SmartBinder
//
//  Created by Zentaro Imai on 2021/05/28.
//

import UIKit
import RealmSwift

class GalleryViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var GalleryCollectionView: UICollectionView!

    var num = Int()
        @IBOutlet var myLabel: UILabel!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
//collectionviewと同じようにデータを取る　
            //代入する
            myLabel.text = String(num)
        }
    
    
    @IBAction func addImage() {
        // 写真のピッカーを設定する
        let picker = UIImagePickerController()
        // 写真をカメラから取得するように設定する
        picker.sourceType = .camera
        // 写真を選ぶピッカーの管理者を自分（self）に設定する
        picker.delegate = self
        // ピッカー（カメラ）を起動する
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func addImagefromG() {
        // 写真のピッカーを設定する
        let picker = UIImagePickerController()
        // 写真をカメラから取得するように設定する
        picker.sourceType = .photoLibrary
        // 写真を選ぶピッカーの管理者を自分（self）に設定する
        picker.delegate = self
        // ピッカー（カメラ）を起動する
        present(picker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Realmの初期化
        let realm = try! Realm()
        // 撮影した写真の取得
        let image = info[.originalImage] as! UIImage
        // 写真を変換
        let data = NSData(data: image.jpegData(compressionQuality: 0.9)!)
        // Realmにデータを保存する
        let pictureData = PictureData()
        // 写真を設定
        pictureData.data = data
        // 写真の説明を設定
        pictureData.title = "Test"
        // Realmにデータを書き込む
        try! realm.write {
            realm.add(pictureData)
        }
        // カメラを終了する
        self.dismiss(animated: true, completion: nil)
    }
            
    

    /*
    // MARK: - Navigation

             Swift Compiler Error Group    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}
