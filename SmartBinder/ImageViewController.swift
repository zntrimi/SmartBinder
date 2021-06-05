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
    
    let realm = try! Realm()
    var pictures: Results<PictureData>!


    

        @IBOutlet weak var scrollView: UIScrollView!
        @IBOutlet weak var imageView: UIImageView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            scrollView.maximumZoomScale = 3
            scrollView.minimumZoomScale = 1
            
            scrollView.delegate = self
            
            let realm = try! Realm()
            pictures = realm.objects(PictureData.self)


            
            imageView.image = UIImage(data: pictures[num].data as Data)

        }
    
    @IBAction func share ()  {
        
        if imageView.image != nil {
            
            let activityVC = UIActivityViewController(activityItems: [imageView.image!, "SmartBinder"], applicationActivities: nil)
            
            self.present(activityVC, animated: true, completion: nil)

        }else{
            print("画像がありません")
        }
    
     

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


