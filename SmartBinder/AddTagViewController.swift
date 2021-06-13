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
        
        
        
        
        
        //　ナビゲーションバーの背景色
        self.navigationController?.navigationBar.barTintColor = UIColor {_ in return #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)}
          // ナビゲーションバーのアイテムの色　（戻る　＜　とか　読み込みゲージとか）
          self.navigationController?.navigationBar.tintColor = .white
          // ナビゲーションバーのテキストを変更する
          self.navigationController?.navigationBar.titleTextAttributes = [
          // 文字の色
            
            .foregroundColor: UIColor.white
          ]
    
   /* 前のviewcontrollerを透過する
view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)

// UIVisualEffectViewを生成する
let visualEffectView = UIVisualEffectView(frame: view.frame)
// エフェクトの種類を設定
visualEffectView.effect = UIBlurEffect(style: .regular)
// UIVisualEffectViewを他のビューの下に挿入するview.insertSubview(visualEffectView, at: 0)
         */
        
        
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

