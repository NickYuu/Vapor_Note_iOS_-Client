//
//  Branch.swift
//  Note_iOS_ Client
//
//  Created by TsungHan on 2017/4/22.
//  Copyright © 2017年 TsungHan. All rights reserved.
//

import Foundation
import ObjectMapper


class User : Mappable{
    
    var name            : String?
    var account         : String?
    var password        : String?
    var id              : Int?
    
    required init?(map: Map){}
    
    init(_ name: String, _ acc: String, _ pwd: String){
        self.name = name
        self.account = acc
        self.password = pwd
    }
    
    func mapping(map: Map) {
        name            <- map["username"]
        account         <- map["account"]
        password        <- map["password"]
        id              <- map["id"]
    }
    
    func toDic() -> [String:String] {
        return ["username": name!,
                "account": account!,
                "password": password!]
    }
    
    
    
}
