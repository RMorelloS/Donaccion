//
//  EditProfileViewController.swift
//  ProyectoFinal_Ricardo_V1
//
//  Created by Morello Santos Ricardo on 10/23/19.
//  Copyright © 2019 Morello Santos Ricardo. All rights reserved.
//

import UIKit
import CoreData

class EditProfileViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        loadDonees()
        txtEmail.underlined(textString: "E-mail")
        txtName.underlined(textString: "Username")
        txtZipCode.underlined(textString: "Zip code")
        txtStreet.underlined(textString: "Street name")
        txtCityAreaDistrict.underlined(textString: "City area/District")
        txtCity.underlined(textString: "City")
        txtComplement.underlined(textString: "Complement")
        txtPassword.underlined(textString: "Password")
        txtConfirmPassword.underlined(textString: "Confirm password")
        
        let donee = fetchUserByEmail(email: appDelegate.userEmail)
        
        if donee != nil{
            txtEmail.text = donee!.correo
            txtZipCode.text = String(donee!.zip_code)
            txtName.text = donee!.nombre
            txtCityAreaDistrict.text = donee!.distrito
            txtComplement.text = donee!.complemento
            txtCity.text = donee!.ciudad
            txtStreet.text = donee!.calle
        }
        // Do any additional setup after loading the view.
    }
    func loadDonees(){
        do{
            donees = try context.fetch(Donatario.fetchRequest())
        }catch let error as NSError{
            print("could not fetch, \(error)")
        }
    }
    private var context : NSManagedObjectContext
    var donees = [Donatario]()
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtZipCode: UITextField!
    @IBOutlet weak var txtStreet: UITextField!
    @IBOutlet weak var txtCityAreaDistrict: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtComplement: UITextField!
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    func textFieldsAreEmpty() -> Bool{
        let textFieldValidationAlert = UIAlertController(title: "Atention", message: "", preferredStyle: .alert)
        textFieldValidationAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        var textFields = [UITextField]()
        textFields.append(txtName)
        textFields.append(txtZipCode)
        textFields.append(txtStreet)
        textFields.append(txtCityAreaDistrict)
        textFields.append(txtCity)
        textFields.append(txtComplement)
        textFields.append(txtEmail)
        textFields.append(txtPassword)
        textFields.append(txtConfirmPassword)
        for textField in textFields {
            if textField.text!.isEmpty{
                textFieldValidationAlert.message = "Field \(textField.placeholder!) cannot be empty."
                present(textFieldValidationAlert, animated: true)
                return true
            }
        }
        return false
    }
    
    required init?(coder aDecoder: NSCoder) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.context = appDelegate.persistentContainer.viewContext
        super.init(coder: aDecoder)
    }
    
    func passwordsDoNotMatch() -> Bool{
        if txtConfirmPassword.text! != txtPassword.text!{
            return true
        }
        return false
    }
    @IBAction func btnEdit(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if textFieldsAreEmpty(){
            return
        }
        if passwordsDoNotMatch(){
            return
        }
        let donee = fetchUserByEmail(email: appDelegate.userEmail)
        let textFieldValidationAlert = UIAlertController(title: "Atention", message: "Edit info?", preferredStyle: .alert)
        textFieldValidationAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (alert) in
                if donee != nil{
                    donee!.calle = self.txtStreet.text!
                    donee!.ciudad = self.txtCity.text!
                    donee!.complemento = self.txtComplement.text!
                    let encrypter = Sha256()
                    let encryptedPassword = encrypter.sha256(str: self.txtPassword.text!)
                    donee!.contrasena = encryptedPassword
                    donee!.correo = self.txtEmail.text!
                    donee!.distrito = self.txtCityAreaDistrict.text!
                    donee!.nombre = self.txtName.text!
                    donee!.zip_code = Int64(self.txtZipCode.text!)!
                    appDelegate.saveContext()
                }
            }))
        textFieldValidationAlert.addAction(UIAlertAction(title: "No", style: .default, handler: {(alert) in
                return
            }))
            present(textFieldValidationAlert, animated: true)
        
        
    }

    func fetchUserByEmail(email:String)->Donatario?{
        
        for donee in donees{
            if donee.correo == email{
                return donee
            }
        }
        return nil
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
