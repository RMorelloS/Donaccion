//
//  DonationsViewController.swift
//  ProyectoFinal_Ricardo_V1
//
//  Created by Morello Santos Ricardo on 10/22/19.
//  Copyright © 2019 Morello Santos Ricardo. All rights reserved.
//

import UIKit

class DonationsViewController: UIViewController {
    @IBOutlet weak var btnClothes : UIButton!
    @IBOutlet weak var btnFurniture : UIButton!
    @IBOutlet weak var btnToys : UIButton!
    @IBOutlet weak var btnAppliances : UIButton!
    @IBOutlet weak var btnElectronics : UIButton!
    @IBOutlet weak var btnBooks : UIButton!
    @IBOutlet weak var btnComputers : UIButton!
    @IBOutlet weak var btnPeripherals : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackground()
        addGradient()
        
        // Do any additional setup after loading the view.
    }
    func addBackground(){
        let background = AddBackgroundImage(background: "donaccion-app-background", bounds: self.view.bounds)
        
        let imageView : UIImageView = background.assignbackground()
        imageView.alpha = 0.5
        self.view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    func addGradient(){
        let gradient = AddGradient(bounds:CGRect(x: 0, y: 0, width: self.view.bounds.maxX, height: self.view.bounds.maxY))
        let gradientView = gradient.addGradientView()
        self.view.addSubview(gradientView)
        self.view.sendSubviewToBack(gradientView)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "segueClothes":
            break
        case "segueFurniture":
            break
        case "segueToys":
            break
        case "segueAppliances":
            break
        case "segueElectronics":
            break
        case "segueBooks":
            break
        case "segueComputers":
            break
        case "seguePeripherals":
            break
        default:
            break
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
