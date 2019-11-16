//
//  AddBackgroundImage.swift
//  ProyectoFinal_Ricardo_V1
//
//  Created by Morello Santos Ricardo on 10/22/19.
//  Copyright © 2019 Morello Santos Ricardo. All rights reserved.
//

import Foundation
import UIKit
class AddBackgroundImage{
    var backgroundName : String = ""
    var bounds : CGRect
    init(background : String, bounds : CGRect) {
        self.bounds = bounds
        self.backgroundName = background
    }
    func assignbackground() -> UIImageView{
        let background = UIImage(named: backgroundName)
        var imageView : UIImageView!
        imageView = UIImageView(frame: bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = CGPoint(x: bounds.midX, y: bounds.midY)
        imageView.alpha = 0.5
        return imageView
    }
}
