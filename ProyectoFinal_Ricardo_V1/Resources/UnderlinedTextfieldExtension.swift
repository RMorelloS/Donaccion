//
//  UnderlinedTextfieldExtension.swift
//  ProyectoFinal_Ricardo_V1
//
//  Created by Morello Santos Ricardo on 10/22/19.
//  Copyright © 2019 Morello Santos Ricardo. All rights reserved.
//

import Foundation
import UIKit
extension UITextField {
    func underlined(textString : String){
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.black.cgColor
        self.backgroundColor = UIColor.clear
        self.textColor = UIColor.black
        self.attributedPlaceholder = NSAttributedString(string: textString,
                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
