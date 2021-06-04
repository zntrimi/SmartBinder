//
//  AddressCollectionViewController.swift
//  SmartBinder
//
//  Created by Zentaro Imai on 2021/05/24.
//
import UIKit
import RealmSwift



class AddressCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet var collectionView: UICollectionView!
    let relm = try! Realm()
    //アドレスのすべてのデータを参照する　配列に似たような形
    let addresses = try! Realm().objects(Address.self)
    var notificationToken: NotificationToken?
    var indexNum = 0
    var attributedText: NSAttributedString!



    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        notificationToken = addresses.observe { [weak self] _ in
        self?.collectionView.reloadData()
            
        }
    }
    
    
    
    //テーブルビューに表示する
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return addresses.count
    }
    //データを持ってくる
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
        "Cell", for: indexPath) as! AddressListCollectionViewCell
        cell.nameLabel.text = addresses[indexPath.row].name
        return cell    }
    
    
    
    
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
             print(indexPath.item)
            indexNum = indexPath.item
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
       nextVC.num = indexNum
        
    }


          }
    
   
    }
    
 

 







