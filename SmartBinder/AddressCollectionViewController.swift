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
}






