//
//  TextField.swift
//  addressFinder
//
//  Created by Milica Jankovic on 10/31/17.
//  Copyright © 2017 Milica Jankovic. All rights reserved.
//

import UIKit
import CoreGraphics

extension UITextField {
    
    func underline() {
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        
    }
}
