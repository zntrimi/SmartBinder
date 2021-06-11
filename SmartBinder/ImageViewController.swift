//
//  ImageViewController.swift
//  SmartBinder
//
//  Created by Zentaro Imai on 2021/05/29.
//

import UIKit
import Accounts
import RealmSwift


class ImageViewController: UIViewController {
    
    var num = Int()
    var image: UIImage!
    var numb = Int()
    
    
    let realm = try! Realm()
    var pictures: List<PictureData>!
    
    var notificationToken: NotificationToken?


    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.maximumZoomScale = 3
        scrollView.minimumZoomScale = 1
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)

        
        scrollView.delegate = self
        
        let realm = try! Realm()
        
        let addresses = realm.objects(Address.self)

        pictures = addresses[num].pictures
        
        
        
        imageView.image = UIImage(data: pictures[num].data as Data)
        
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
        let alert: UIAlertController = UIAlertController(title: "注意", message: "削除してもいいですか？", preferredStyle: .actionSheet)
        let canselAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .cancel) { (UIAlertAction) in
            print("キャンセル")
        }
        let okAction: UIAlertAction = UIAlertAction(title: "削除", style: .destructive) { (UIAlertAction) in
            
            let addresses = self.realm.objects(Address.self)
            //pictureはPictureDataを元にして作ります
            let picture = PictureData()
            
            try! self.realm.write {
             //   addresses[num].pictures[numb].remove()
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


