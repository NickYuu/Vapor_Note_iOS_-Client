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
    
    
    required init?(map: Map){}
    
    init(_ content: String, _ user_id: Int, _ title: String){
        self.content = content
        self.user_id = user_id
        self.title = title
    }
    
    func mapping(map: Map) {
        content         <- map["content"]
        user_id         <- map["user_id"]
        title           <- map["title"]
    }
    
    func toDic() -> [String:Any] {
        return ["content": content!,
                "user_id": user_id!,
                "title": title!]
    }
    
    
    
}
