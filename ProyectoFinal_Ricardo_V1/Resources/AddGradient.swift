//
//  AddGradient.swift
//  ProyectoFinal_Ricardo_V1
//
//  Created by Morello Santos Ricardo on 10/22/19.
//  Copyright © 2019 Morello Santos Ricardo. All rights reserved.
//

import Foundation

import UIKit

class AddGradient{
    let bounds : CGRect
    
    init(bounds : CGRect) {
        self.bounds = bounds
    }
    func addGradientView() -> UIView{
        let gradientView = UIView(frame: bounds)
        let gradient = CAGradientLayer()
        gradient.frame = gradientView.bounds
        
        let gradientColorInitial = UIColor(red:0.06, green:0.69, blue:0.90, alpha: 1.0).cgColor
        let gradientColorFinal = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0).cgColor
        
        gradient.colors = [gradientColorInitial, gradientColorFinal]
        gradientView.layer.insertSublayer(gradient, at: 0)
        return gradientView
    }
}
