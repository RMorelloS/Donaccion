//
//  SignUp1ViewController.swift
//  ProyectoFinal_Ricardo_V1
//
//  Created by Morello Santos Ricardo on 10/22/19.
//  Copyright © 2019 Morello Santos Ricardo. All rights reserved.
//

import UIKit
import CoreData
import CommonCrypto
class SignUp1ViewController: UIViewController, UITextFieldDelegate {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //
        // Do any additional setup after loading the view.
        addBackground()
        addGradient()
        txtEmail.underlined(textString: "E-mail")
        txtPassword.underlined(textString: "Password")
        txtConfirmPassword.underlined(textString: "Confirm password")
        txtEmail.delegate = self
        txtPassword.delegate = self
        txtConfirmPassword.delegate = self
        donatarioBaseDatos = Donatario(entity: Donatario.entity(), insertInto: context)
    }
    
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        do{
            donatarios = try context.fetch(Donatario.fetchRequest())
        }catch let error as NSError{
            print("could not fetch, \(error)")
        }
    }
    required init?(coder aDecoder: NSCoder) {
        self.context = appDelegate.persistentContainer.viewContext
        super.init(coder: aDecoder)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var btnDone : UIButton!
    private var context : NSManagedObjectContext
    private var donatarios = [Donatario]()
    var donatarioBaseDatos = Donatario()
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueSignUp2"{
            let signUp2ViewController = segue.destination as! SignUp2ViewController
            signUp2ViewController.donatarios = self.donatarios
            signUp2ViewController.donatarioBaseDatos = self.donatarioBaseDatos
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        btnDone.isEnabled = false
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        btnDone.isEnabled = true
    }
   
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        let textFieldValidationAlert = UIAlertController(title: "Atention", message: nil, preferredStyle: .alert)
        textFieldValidationAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        if textField.placeholder == "E-mail"{
            var foundEmailOnDatabase = false
            for dons in donatarios{
                if let storedEmail = dons.correo{
                    if textField.text! == storedEmail{
                        foundEmailOnDatabase = true
                    }
                }
            }
            if foundEmailOnDatabase {
                let textFieldEmailAlreadyInUse = UIAlertController(title: "Invalid e-mail", message: "E-mail already in use. Choose an option:", preferredStyle: .alert)
                textFieldEmailAlreadyInUse.addAction(UIAlertAction(title: "Use another e-mail", style: .default, handler: {
                    (alert: UIAlertAction!) in
                    textField.text! = ""
                }))
                textFieldEmailAlreadyInUse.addAction(UIAlertAction(title: "Login", style: .default, handler: {
                    (alert: UIAlertAction!) in
                        self.performSegue(withIdentifier: "segueSignUp1_Login", sender: nil)
                }))
                present(textFieldEmailAlreadyInUse, animated: true)
            }
            donatarioBaseDatos.correo = textField.text!
        }else if textField.placeholder == "Password"{
            if textField.text!.isEmpty{
                textFieldValidationAlert.message = "The password field cannot be empty."
                present(textFieldValidationAlert, animated: true)
                return false
            }
            let encrypter = Sha256()
            let encryptedPassword = encrypter.sha256(str: txtPassword.text!)
            donatarioBaseDatos.contrasena = encryptedPassword
            print("encrypted password: \(encryptedPassword)")
        }else if textField.placeholder == "Confirm password"{
            if textField.text!.isEmpty{
                textFieldValidationAlert.message = "The confirm password field cannot be empty."
                present(textFieldValidationAlert, animated: true)
                return false
            }
        }
        return true
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "segueSignUp2"{
            let textFieldValidationAlert = UIAlertController(title: "Atention", message: "", preferredStyle: .alert)
            textFieldValidationAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            if txtPassword.text!.isEmpty{
                textFieldValidationAlert.message = "The password field cannot be empty."
                present(textFieldValidationAlert, animated: true)
                return false
            }else if txtConfirmPassword.text!.isEmpty{
                textFieldValidationAlert.message?.append("The confirm password field cannot be empty.")
                present(textFieldValidationAlert, animated: true)
                return false
            }else if txtEmail.text!.isEmpty{
                textFieldValidationAlert.message = "The e-mail field cannot be empty."
                present(textFieldValidationAlert, animated: true)
                return false
            }
            if txtConfirmPassword.text! != txtPassword.text!{
                textFieldValidationAlert.message = "Passwords do not match."
                txtPassword.becomeFirstResponder()
                present(textFieldValidationAlert, animated: true)
                return false
            }
            return true
        }
        return true
    }
    
    func addBackground(){
        let background = AddBackgroundImage(background: "signup1_background_image", bounds: self.view.bounds)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
