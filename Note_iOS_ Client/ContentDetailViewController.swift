//
//  ContentDetailViewController.swift
//  iOSClientForPerfect
//
//  Created by TsungHan on 2017/4/13.
//  Copyright © 2017年 TsungHan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


/// 當前頁面類型
///
/// - Add: 添加Note
/// - Update: 更新Note
enum ContentDetailType {
    case Add, Update
    func title() -> String {
        switch self {
        case .Add:
            return "新增"
        case .Update:
            return "更新"
        }
    }
}
typealias RefreshMainTableView = () -> Void
class ContentDetailViewController: UIViewController {
    
    fileprivate let bag = DisposeBag()
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentTextView: UITextView!
    var updateMainVC : RefreshMainTableView!
    
    var content: Content?
    var vcType: ContentDetailType = .Add
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configCurrentVC()
    }
    
    //MARK: - Setter and Getter
    func setUpdateMainVC(update: @escaping RefreshMainTableView) {
        self.updateMainVC = update
    }
    
    //MARK: - Response Event
    @IBAction func tapGestrueRecognizer(_ sender: Any) {
        self.view.endEditing(true)
    }

    
    func tapSubmitButton(_ sender: Any) {
        if self.titleTextField.text == "" {
            UIAlertController(title: "請輸入標題").show()
            return
        }
        
        if self.contentTextView.text == "" {
            UIAlertController(title: "請輸入内容").show()
            return
        }
        
        switch vcType {
        case .Add:
            content = Content(titleTextField.text!, contentTextView.text!)

//            let data: Data = UIImagePNGRepresentation(#imageLiteral(resourceName: "note"))!
//            var values = [UInt8](repeating:0, count:data.count)
//            data.copyBytes(to: &values, count: data.count)
//            
//            content?.image = data
            
            NoteData.addContent(content!)
                .subscribe(onNext: {
                    if $0.1 {
                        UserInfo.shared.contents = $0.0
                        _ = self.navigationController?.popViewController(animated: true)
                    }
                    else {
                        UIAlertController(title: "新增失敗\n請稍後再試一次").show()
                    }
                }).addDisposableTo(bag)
        case .Update:
            content?.title = self.titleTextField.text!
            content?.content = self.contentTextView.text!
            NoteData.modifyContent(content!)
                .subscribe(onNext: {
                    if $0.1 {
                        UserInfo.shared.contents = $0.0
                        _ = self.navigationController?.popViewController(animated: true)
                    }
                    else {
                        UIAlertController(title: "修改失敗\n請稍後再試一次").show()
                    }
                }).addDisposableTo(bag)
        }
        
    }
    
    
    //MARK: - Private Method
    
    /// 添加分享按鈕
    func addSubmitButton() {
        let barItem = UIBarButtonItem(title: self.vcType.title(), style: .plain, target: self, action: #selector(self.tapSubmitButton(_:)))
        self.navigationItem.rightBarButtonItem = barItem
    }

    
    private func configCurrentVC() {
        
        if content == nil {
            vcType = .Add
        } else {
            vcType = .Update
            titleTextField.text = content?.title
            contentTextView.text = content?.content
        }
        addSubmitButton()
        title = vcType.title()
        //navigationItem.rightBarButtonItem?.title = vcType.title()
    }
    
    
    /// 添加或者請求更新
//    private func requestAddOrUpdate() {
//        switch self.vcType {
//        case .Add:
//            createAddOrUpdateRequestObj().contentAdd(model: self.content)
//        case .Update:
//            createAddOrUpdateRequestObj().contentUpdate(model: self.content)
//        }
//    }
    
    
    /// 創建添加或者請求
    ///
    /// - Returns:
//    private func createAddOrUpdateRequestObj() -> ContentRequest {
//        return ContentRequest(start: {
//        }, success: { (content) in
//            DispatchQueue.main.async {
//                if self.updateMainVC != nil {
//                    self.updateMainVC()
//                    self.navigationController?.popViewController(animated: true)
//                }
//            }
//            
//        }) { (errorMessage) in
//            DispatchQueue.main.async {
//                Tools.showTap(message: errorMessage, superVC: self)
//            }
//        }
//    }

}
