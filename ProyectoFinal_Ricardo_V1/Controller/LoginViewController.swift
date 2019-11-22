//
//  LoginViewController.swift
//  ProyectoFinal_Ricardo_V1
//
//  Created by Morello Santos Ricardo on 10/22/19.
//  Copyright © 2019 Morello Santos Ricardo. All rights reserved.
//

import UIKit
import CoreData


class LoginViewController: UIViewController, UITextFieldDelegate {

    var donatarios = [Donatario]()
    var donatarioBaseDatos = Donatario()
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var context : NSManagedObjectContext
    @IBOutlet weak var txtLogin: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var outletBtnLogin: UIButton!
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let txtFields = [txtLogin, txtPassword]
        if identifier == "segueLoginHome"{
            for txtField in txtFields{
                if txtField!.text!.isEmpty{
                    let textFieldValidationAlert = UIAlertController(title: "Atention", message: "The \(txtField!.placeholder!) field cannot be empty.", preferredStyle: .alert)
                    textFieldValidationAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    present(textFieldValidationAlert, animated: true)
                    return false
                }
            }
        }
        var userIsValid = false
        let encrypter = Sha256()
        for don in donatarios{
            let loginEncryptedPassword = encrypter.sha256(str: txtPassword.text!)
            if let emailDatabase = don.correo{
                if let passwordDatabase = don.contrasena{
                    
                    if (emailDatabase == txtLogin.text!) && (passwordDatabase == loginEncryptedPassword){
                        appDelegate.userEmail = txtLogin.text!
                        userIsValid = true
                    }
                }
            }
        }
        if userIsValid{
            return true
        }else{
            return false
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        outletBtnLogin.isEnabled = false
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        outletBtnLogin.isEnabled = true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text!.isEmpty{
            let textFieldValidationAlert = UIAlertController(title: "Atention", message: "The \(textField.placeholder!) field cannot be empty.", preferredStyle: .alert)
            textFieldValidationAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(textFieldValidationAlert, animated: true)
            return false
        }
        return true
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.context = appDelegate.persistentContainer.viewContext
        super.init(coder: aDecoder)
    }
    @IBAction func forgotPassword(_ sender: Any){

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addBackground()
        addGradient()
        txtLogin.underlined(textString: "E-mail")
        txtPassword.underlined(textString: "Password")
        txtLogin.delegate = self
        txtPassword.delegate = self
        rememberMeSwitch.setOn(false, animated: false)
    
        let defaults : UserDefaults? = UserDefaults.standard
        rememberMeSwitch.addTarget(self, action: #selector(stateChangedToFalse), for: .valueChanged)
        if let _ = (defaults?.bool(forKey: "isRemember")){
            if let savedUserEmail = defaults?.value(forKey: "savedUserEmail"){
                txtLogin.text = (savedUserEmail as! String)
                rememberMeSwitch.setOn(true, animated: false)
            }
        }else{
            rememberMeSwitch.setOn(false, animated: false)
        }
    }
    @objc func stateChangedToFalse(_ switchState : UISwitch){
        let defaults : UserDefaults? = UserDefaults.standard
        if !switchState.isOn{
            defaults?.set(false, forKey: "isRemember")
            defaults?.set(nil, forKey: "savedUserEmail")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        do{
            donatarios = try context.fetch(Donatario.fetchRequest())
        }catch let error as NSError{
            print("could not fetch, \(error)")
        }
    }
    
    
    @IBOutlet weak var rememberMeSwitch : UISwitch!
  
    func addBackground(){
        let background = AddBackgroundImage(background: "login_background_image", bounds: self.view.bounds)
        let imageView : UIImageView = background.assignbackground()
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
        if segue.identifier == "segueLoginHome"{
            let defaults : UserDefaults? = UserDefaults.standard
            if rememberMeSwitch.isOn{
                defaults?.set(true, forKey: "isRemember")
                defaults?.set(txtLogin.text!, forKey: "savedUserEmail")
            }else{
                defaults?.set(false, forKey: "isRemember")
                defaults?.set(nil, forKey: "savedUserEmail")
            }
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}

