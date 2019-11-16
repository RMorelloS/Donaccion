//
//  EditProfileViewController.swift
//  ProyectoFinal_Ricardo_V1
//
//  Created by Morello Santos Ricardo on 10/23/19.
//  Copyright © 2019 Morello Santos Ricardo. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmail.underlined(textString: "E-mail")
        txtName.underlined(textString: "Username")
        txtZipCode.underlined(textString: "Zip code")
        txtStreet.underlined(textString: "Street name")
        txCityAreaDistrict.underlined(textString: "City area/District")
        txtComplement.underlined(textString: "Complement")
        txtPassword.underlined(textString: "Password")
        txtConfirmPassword.underlined(textString: "Confirm password")
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtZipCode: UITextField!
    @IBOutlet weak var txtStreet: UITextField!
    @IBOutlet weak var txCityAreaDistrict: UITextField!

    @IBOutlet weak var txtComplement: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
