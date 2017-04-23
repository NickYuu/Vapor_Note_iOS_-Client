//
//  MainPageCell.swift
//  Note_iOS_ Client
//
//  Created by TsungHan on 2017/4/23.
//  Copyright © 2017年 TsungHan. All rights reserved.
//

import UIKit

class MainPageCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var timeLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
//    func setContent(content: ContentModel) {
//        titleLabel.text = content.title
//        timeLable.text = content.createTime
//    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
