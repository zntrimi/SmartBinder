//
//  Address.swift
//  SmartBinder
//
//  Created by Zentaro Imai on 2021/05/24.
//

import Foundation
import RealmSwift

class Address: Object {
    
    @objc dynamic var name: String = ""

}

class PictureData: Object {
    // 写真を保存するdata
    @objc dynamic var data: NSData!
    // 写真の説明を保存するtitle
    @objc dynamic var title = ""
}
