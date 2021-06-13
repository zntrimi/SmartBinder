//
//  AddressCollectionViewController.swift
//  SmartBinder
//
//  Created by Zentaro Imai on 2021/05/24.


import UIKit
import RealmSwift




class AddressCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var collectionView: UICollectionView!
    let realm = try! Realm()
    //アドレスのすべてのデータを参照する　配列に似たような形
    let addresses = try! Realm().objects(Address.self)
    var notificationToken: NotificationToken?
    var indexNumb = 0
    var attributedText: NSAttributedString!
    @IBOutlet var label:UILabel!
    var image: UIImage!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        notificationToken = addresses.observe { [weak self] _ in
            self?.collectionView.reloadData()
            
        }
        

        
        //　ナビゲーションバーの背景色
        self.navigationController?.navigationBar.barTintColor = UIColor {_ in return #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)}
          // ナビゲーションバーのアイテムの色　（戻る　＜　とか　読み込みゲージとか）
          self.navigationController?.navigationBar.tintColor = .white
          // ナビゲーションバーのテキストを変更する
          self.navigationController?.navigationBar.titleTextAttributes = [
          // 文字の色
            
            .foregroundColor: UIColor.white
          ]
    }
    
    
    
    //テーブルビューに表示する
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return addresses.count
    }
    //データを持ってくる
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       // var pictures: List<PictureData>!

    let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                                                        "Cell", for: indexPath) as! AddressListCollectionViewCell
    cell.nameLabel.text = addresses[indexPath.row].name
        
    /*    var pictures: List<PictureData>!
        
        let addresses = realm.objects(Address.self)
        
        
        pictures = addresses[indexPath.row].pictures
        cell.thumbnail.image = UIImage(data: pictures[1].data as Data)
        */
        return cell    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        indexNumb = indexPath.item
        self.performSegue(withIdentifier: "toGallery", sender: nil)
        
    }
    
    @IBAction func register(){
        
        // registerボタンを押したら、toSというIDを持つsegueに移動する
        self.performSegue(withIdentifier: "toGallery", sender: nil)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if (segue.identifier == "toGallery") {
            
            // SecondViewControllerに移動する変数vcを定義する
            let nextVC = segue.destination as! GalleryViewController
            
            nextVC.numb = indexNumb
            
        }
        
        
    }
    
    @IBAction func delete() {
        try! realm.write {
            realm.deleteAll()
        }}
    
    
}











