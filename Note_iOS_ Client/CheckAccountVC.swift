//
//  CheckAccountVC.swift
//  Note_iOS_ Client
//
//  Created by TsungHan on 2017/4/22.
//  Copyright © 2017年 TsungHan. All rights reserved.
//

import UIKit
import RxSwift

class CheckAccountVC: UIViewController {
    
    fileprivate let bag = DisposeBag()
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    @IBAction func submit(_ sender: UIButton) {
        guard let account = textField.text else { return }
        if account.characters.count < 4 {
            UIAlertController(title: "錯誤", message: "帳號長度須大於三個字").show()
            return
        }
        check(account)
    }
}

// MARK :- Networking
extension CheckAccountVC {
    
    func check(_ account:String) {
        NoteData.getUser(account)
            .subscribe( onNext: { [unowned self] in
                UserInfo.shared.update($0)
                print(UserInfo.shared.name)
                self.performSegue(withIdentifier: "account", sender: nil)
            }, onError: { [unowned self] _ in
                UserInfo.shared.clear()
                UserInfo.shared.account = self.textField.text!
                self.performSegue(withIdentifier: "account", sender: nil)
            }).addDisposableTo(bag)
    }
    
}
