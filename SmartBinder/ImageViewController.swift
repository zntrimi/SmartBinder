//
//  ImageViewController.swift
//  SmartBinder
//
//  Created by Zentaro Imai on 2021/05/29.
//

import UIKit
import Accounts
import RealmSwift
import SwiftyJot


class ImageViewController: UIViewController {
    
    var numb: Int!
    var image: UIImage!
    var num: Int!
    
    var alertController: UIAlertController!

    
    let realm = try! Realm()
    
    var notificationToken: NotificationToken?
 //   var image: UIImage!


    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.maximumZoomScale = 3
        scrollView.minimumZoomScale = 1
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)

        
        scrollView.delegate = self
        
        let realm = try! Realm()
        
        var pictures: List<PictureData>!

        
        let addresses = realm.objects(Address.self)

        pictures = addresses[numb].pictures
        
        
        
        imageView.image = UIImage(data: pictures[num].data as Data)
        
        print(num)
        print(numb)
        
    }
    
    
    @IBAction func share ()  {
        
        if imageView.image != nil {
            
            let activityVC = UIActivityViewController(activityItems: [imageView.image!], applicationActivities: nil)
            
            self.present(activityVC, animated: true, completion: nil)
            
        }else{
            print("画像がありません")
        }
                
    }
    
    
    @IBAction func deleteimage (_ sender: Any) {
        //アラートを表示する↓＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
        let alert: UIAlertController = UIAlertController(title: "Caution", message: "Would you like to delete this image?", preferredStyle: .actionSheet)
        let canselAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { (UIAlertAction) in
            print("Cancel")
        }
        let okAction: UIAlertAction = UIAlertAction(title: "削除", style: .destructive) { (UIAlertAction) in
            
            
   
            
            try! self.realm.write {
                
                
                
                let addresses = self.realm.objects(Address.self)
                //pictureはPictureDataを元にして作ります
                let picture = PictureData()
                
                self.realm.delete(addresses[self.numb].pictures[self.num])

         //   addresses.pictures[num].delete(picture)
                
            }
            
            
            //アラートが消えるのと画面遷移が重ならないように0.5秒後に画面遷移する
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                //前の画面に戻る
                self.navigationController?.popViewController(animated: true)
                
            }
            
            
            
            
        }
        //アラートに設定を反映させる
        alert.addAction(okAction)
        alert.addAction(canselAction)
        //アラート画面を表示させる
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
}

extension ImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale > 1 {
            if let image = imageView.image {
                let ratioW = imageView.frame.width / image.size.width
                let ratioH = imageView.frame.height / image.size.height
                
                let ratio = ratioW < ratioH ? ratioW : ratioH
                let newWidth = image.size.width * ratio
                let newHeight = image.size.height * ratio
                let conditionLeft = newWidth*scrollView.zoomScale > imageView.frame.width
                let left = 0.5 * (conditionLeft ? newWidth - imageView.frame.width : (scrollView.frame.width - scrollView.contentSize.width))
                let conditioTop = newHeight*scrollView.zoomScale > imageView.frame.height
                
                let top = 0.5 * (conditioTop ? newHeight - imageView.frame.height : (scrollView.frame.height - scrollView.contentSize.height))
                
                scrollView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
                
            }
        } else {
            scrollView.contentInset = .zero
        }
    }
    
    func alert(title:String, message:String) {
        alertController = UIAlertController(title: title,
                                   message: message,
                                   preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK",
                                       style: .default,
                                       handler: nil))
        present(alertController, animated: true)
    }

    
    
    @IBAction func addTag () {
        
        //はじめが大文字だとclass名が多い
        //①アドレス一覧を取得　②何番目かを知る(num)　③
        let addresses = self.realm.objects(Address.self)
        //pictureはPictureDataを元にして作ります
        let picture = PictureData()
        //ココに問題あり
        picture.data = NSData(data: (imageView.image?.jpegData(compressionQuality: 0.9)!)!)
        
        
        picture.title = addresses[numb].pictures[num].title


                
        try! self.realm.write {
           addresses[numb].pictures[num] = picture
        }
        

        
        alert(title: "Success!",
                    message: "Image is saved")
        
        
        // ②遷移先ViewControllerのインスタンス取得
        
        //   self.show(goToAdd, sender: self)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func buttonTapped() {

        let swiftyJot = SwiftyJot()
        var config = SwiftyJot.Config()
        config.backgroundColor = .gray
        config.title = "Example"
        config.tintColor = .darkGray
        config.buttonBackgroundColor = .white
        config.brushColor = .red
        config.brushSize = 8.0
        config.showMenuButton = true
        config.showPaletteButton = true
        swiftyJot.config = config

        swiftyJot.present(sourceImageView: imageView, presentingViewController: self)
    }

    
    
    
}












/*
 return addresses.count
 }
 //データを持ってくる
 func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
 let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
 "Cell", for: indexPath) as! AddressListCollectionViewCell
 cell.nameLabel.text = addresses[indexPath.row].name
 return cell    }
 
 */

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */


