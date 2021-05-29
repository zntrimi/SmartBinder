//
//  GalleryViewController.swift
//  SmartBinder
//
//  Created by Zentaro Imai on 2021/05/28.
//

import UIKit

class GalleryViewController: UIViewController {
    
    @IBOutlet var GalleryCollectionView: UICollectionView!

    var num = Int()
        @IBOutlet var myLabel: UILabel!
    


        override func viewDidLoad() {
            super.viewDidLoad()
            

            //代入する
            myLabel.text = String(num)
            
    

    /*
    // MARK: - Navigation

             Swift Compiler Error Group    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}
