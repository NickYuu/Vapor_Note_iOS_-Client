//
//  MainTableViewController.swift
//  Note_iOS_ Client
//
//  Created by TsungHan on 2017/4/23.
//  Copyright © 2017年 TsungHan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainTableViewController: UITableViewController {
    
    fileprivate let bag = DisposeBag()
    
    var contents: Array<Content> = []
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.fetchList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contents = UserInfo.shared.contents
        tableView.reloadData()
    }
    
    //MARK: - Response Event
    @IBAction func tapLoginOutButton(_ sender: Any) {
        //TODO :- 登出
        UserInfo.shared.clear()
        UIApplication.shared.delegate?.window??.rootViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginVCNC")
    }
    
    @IBAction func tapRefreshButton(_ sender: Any) {
        self.fetchList()
    }
    
    @IBAction func tapAddButton(_ sender: Any) {
        guard let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ContentDetailViewController") as? ContentDetailViewController else {
            return
        }
        vc.setUpdateMainVC {
            self.fetchList()
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Private Method
    
    private func fetchList() {
        //TODO :- 查詢所有Note
        NoteData.contents(UserInfo.shared.id)
            .subscribe(onNext: { [unowned self] in
                UserInfo.shared.contents = $0
                self.contents = UserInfo.shared.contents
                self.tableView.reloadData()
            }).addDisposableTo(bag)
        
    }
    
    func deleteItem(contentId: Int) {
        //TODO :- 刪除Note
        NoteData.deleteContent(contentId)
            .subscribe(onNext: { [unowned self] in
                if $0.1 {
                    UserInfo.shared.contents = $0.0
                    self.contents = $0.0
                    self.tableView.reloadData()
                }
                else {
                    UIAlertController(title: "刪除失敗\n請稍後再試一次").show()
                }
            }).addDisposableTo(bag)
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contents.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainPageCell", for: indexPath) as! MainPageCell
        cell.setContent(content: self.contents[indexPath.row])
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ContentDetailViewController") as? ContentDetailViewController else {
            return
        }
        vc.content = self.contents[indexPath.row]
        vc.setUpdateMainVC {
            self.fetchList()
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "刪除"
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard let contentId = self.contents[indexPath.row].id else { return }
        print(contentId)
        self.deleteItem(contentId: contentId)
    }
    
}
