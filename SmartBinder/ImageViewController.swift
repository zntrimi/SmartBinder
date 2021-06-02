//
//  ImageViewController.swift
//  SmartBinder
//
//  Created by Zentaro Imai on 2021/05/29.
//

import UIKit
import Accounts


class ImageViewController: UIViewController {
    

    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func share ()  {
     let text = "This is the text…"
     let textShare = [ text ]
     let activityViewController = UIActivityViewController(activityItems: textShare , applicationActivities: nil)
     activityViewController.popoverPresentationController?.sourceView = self.view
     self.present(activityViewController, animated: true, completion: nil)
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


