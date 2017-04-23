//
//  UIView.swift
//  Note_iOS_ Client
//
//  Created by TsungHan on 2017/4/22.
//  Copyright © 2017年 TsungHan. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable var cnRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
}
