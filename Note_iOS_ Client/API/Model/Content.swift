//
//  Content.swift
//  Note_iOS_ Client
//
//  Created by TsungHan on 2017/4/23.
//  Copyright © 2017年 TsungHan. All rights reserved.
//

import ObjectMapper
/*
 {
 "content": "Hello Word!!",
 "id": 1,
 "title": "Hello",
 "user_id": 11
 }
 */

class Content : Mappable{
    
    var content         : String?
    var user_id         : Int?
    var title           : String?
    var id              : Int?
//    var image           : Data?
    
    
    required init?(map: Map){}
    
    init(_ content: String, _ title: String){
        self.content = content
        self.user_id = UserInfo.shared.id
        self.title = title
    }
    
    func mapping(map: Map) {
        content         <- map["content"]
        user_id         <- map["user_id"]
        title           <- map["title"]
        id              <- map["id"]
//        image           <- map["image"]
    }
    
    func toDic() -> [String:Any] {
        let id = UserInfo.shared.id
        return ["content": content!,
                "user_id": id,
//                "image":image!,
                "title": title!]
    }
    
    
    
}
