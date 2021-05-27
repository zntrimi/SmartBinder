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
    let relm = try! Realm()
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
    }
    //テーブルビューに表示する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addresses.count
    }
    //データを持ってくる
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
        "Cell", for: indexPath) as! AddressListTableViewCell
        cell.nameLabel.text = addresses[indexPath.row].name
        return cell    }
    
    @IBAction func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
}
