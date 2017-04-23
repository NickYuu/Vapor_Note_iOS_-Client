//
//  LoginOrRegisterVC.swift
//  Note_iOS_ Client
//
//  Created by TsungHan on 2017/4/22.
//  Copyright © 2017年 TsungHan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginOrRegisterVC: UIViewController {
    
    fileprivate let bag = DisposeBag()
    
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var pwdTF: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var noteLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBtn()
    }
    
}

extension LoginOrRegisterVC {
    
    func setupView() {
        if UserInfo.shared.password == "" {
            title = "註冊"
            button.setTitle("註冊", for: .normal)
            view.backgroundColor = #colorLiteral(red: 0.59290874, green: 0.6549317241, blue: 0.9616780877, alpha: 1)
            userNameTF.isHidden = false
            noteLabel.text = "請輸入用於註冊之密碼"
        }
        else {
            title = "登入"
            button.setTitle("登入", for: .normal)
            view.backgroundColor = #colorLiteral(red: 0.5389524102, green: 0.7830395103, blue: 0.7579553127, alpha: 1)
            userNameTF.isHidden = true
            noteLabel.text = ""
        }
    }
    
    func setupBtn() {
        button.rx.tap
            .throttle(1, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] in
                if self.title == "註冊" {
                    let user = User(self.userNameTF.text!, UserInfo.shared.account, self.pwdTF.text!)
                    NoteData.newUser(user)
                        .subscribe(onNext: {
                            UserInfo.shared.update($0)
                        }).addDisposableTo(self.bag)
                }
                else {
                    if self.pwdTF.text == UserInfo.shared.password {
                        NoteData.contents(UserInfo.shared.id)
                            .subscribe(onNext: {
                                UserInfo.shared.contents = $0
                            }).addDisposableTo(self.bag)
                        print("OK")
                    }
                    else {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
                
            }).addDisposableTo(bag)
    }
    
    
}
