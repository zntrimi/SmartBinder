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
    

    var numb: Int!


    
    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage!
    
    
    let realm = try! Realm()
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
                
        print(numb)
        
        
    }
    
    //新しい行を追加する
    @IBAction func addTag () {
        
        //はじめが大文字だとclass名が多い
        //①アドレス一覧を取得　②何番目かを知る(num)　③
        let addresses = self.realm.objects(Address.self)
        //pictureはPictureDataを元にして作ります
        let picture = PictureData()
        
        picture.data = NSData(data: image.jpegData(compressionQuality: 0.9)!)
        
        picture.title = nameTextField.text!
        
        try! self.realm.write {
           addresses[numb].pictures.append(picture)
        }
        

        
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

