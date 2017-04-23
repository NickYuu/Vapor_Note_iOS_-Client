//
//  UserInfo.swift
//  Note_iOS_ Client
//
//  Created by TsungHan on 2017/4/22.
//  Copyright © 2017年 TsungHan. All rights reserved.
//

import UIKit

class UserInfo {
    
    static let shared = UserInfo()
    private init() {}
    
    var name            : String = ""
    var account         : String = ""
    var password        : String = ""
    var id              : Int    = 0
    
    var contents        : [Content] = []
    
    func update(_ user: User) {
        self.name = user.name!
        self.account = user.account!
        self.password = user.password!
        self.id = user.id!
    }
    
    func clear() {
        self.name = ""
        self.account = ""
        self.password = ""
        self.id = 0
        contents = []
    }
    
}

