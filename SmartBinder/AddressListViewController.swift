//
//  AddressListViewController.swift
//  SmartBinder
//
//  Created by Zentaro Imai on 2021/05/25.
//


import UIKit
import RealmSwift

class AddressListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var tableView: UITableView!
    let realm = try! Realm()
    //アドレスのすべてのデータを参照する　配列に似たような形
    let addresses = try! Realm().objects(Address.self)
    var notificationToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        notificationToken = addresses.observe { [weak self] _ in
            self?.tableView.reloadData()
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addresses.count
    }
    //データを持ってくる
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = addresses[indexPath.row].name
        return cell
    }
    
        
    @IBAction func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    //スワイプしたセルを削除　※arrayNameは変数名に変更してください
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            
            try! realm.write {
                realm.delete(addresses[indexPath.row])
            }
            
            
            
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    
}


