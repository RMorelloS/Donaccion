//
//  DonateViewController.swift
//  ProyectoFinal_Ricardo_V1
//
//  Created by Morello Santos Ricardo on 10/22/19.
//  Copyright © 2019 Morello Santos Ricardo. All rights reserved.
//

import UIKit

class DonateViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addBackground()
        addGradient()
        addIconsToButtons()
        self.view.bringSubviewToFront(btnCamera)
        
    }
    
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
   
    
    @IBOutlet weak var btnCamera: UIButton!
    
    func addIconsToButtons(){
        let addImage = UIImage(.add);
        btnAdd.setImage(addImage, for: .normal)
        let cancelImage = UIImage(.stop);
        btnCancel.setImage(cancelImage, for: .normal)
        let cameraImage = UIImage(.camera)
        btnCamera.setImage(cameraImage, for: .normal)
        
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
