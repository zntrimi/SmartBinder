//
//  GalleryViewController.swift
//  SmartBinder
//
//  Created by Zentaro Imai on 2021/05/28.
//

import UIKit
import RealmSwift

class GalleryViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate {
    
    @IBOutlet var GalleryCollectionView: UICollectionView!
    
    var num = Int()
    @IBOutlet var myLabel: UILabel!
    var pictures: Results<PictureData>!
    //    let pictures = try! Realm().objects(PictureData.self)
    var notificationToken: NotificationToken?
    var indexNum = 0
    var attributedText: NSAttributedString!
    
    let realm = try! Realm()
//    let storyboard = UIStoryboard(name: "AddTag", bundle: nil)
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        //notificationToken = addresses.observe { [weak self] _ in
        //   self?.collectionView.reloadData()
        
        //collectionviewと同じようにデータを取る
        //代入する
        myLabel.text = String(num)
        
        
        GalleryCollectionView.delegate = self
        GalleryCollectionView.dataSource = self
        
        
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // picturesの配列の中身の数を表示する
        return pictures.count
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Realmの初期化
        let realm = try! Realm()
        // Realmから保存されている写真のデータを取得
        pictures = realm.objects(PictureData.self)
        // CollectionViewを更新
        GalleryCollectionView.reloadData()
        
        
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        
    }
    
    
    
    // さっき作ったCollectionViewのセルにアイテムを表示
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Main.StoryboardのCellを探してくる
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GalleryCellViewController
        // imageViewに写真を表示
        cell.OneImageView.image = UIImage(data: pictures[indexPath.row].data as Data)
        // Labelにタイトルを表示
        // z1  cell.titleLabel.text = pictures[indexPath.row].title
        // Cellに適用する
        return cell
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
        
        self.performSegue(withIdentifier: "goToAdd", sender: nil)


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
        
        self.performSegue(withIdentifier: "goToAdd", sender: nil)

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
      //  pictureData.title = "Test"
        // Realmにデータを書き込む
        try! realm.write {
            realm.add(pictureData)
        }
        // カメラを終了する
        self.dismiss(animated: true, completion: nil)
    }
    
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

       
       if (segue.identifier == "goToAdd") {
           
           // SecondViewControllerに移動する変数vcを定義する
      
   //         let nextVC = segue.destination as! AddTagViewController
    //    nextVC.num = indexNum
          
           
       }


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
