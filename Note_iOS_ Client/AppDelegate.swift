//
//  AppDelegate.swift
//  Note_iOS_ Client
//
//  Created by TsungHan on 2017/4/22.
//  Copyright © 2017年 TsungHan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }


}

// 就專案 在 build-setting 搜尋 custom flag 添加 DEBUG
func YuLog<T>(_ message : T,path : String = #file,funcname : String = #function,funcline : Int = #line){
    #if DEBUG
        print("\((path as NSString).pathComponents.last!):[\(funcline)] \(funcname): \(message)")
    #endif
}
