//
//  SignUp2ViewController.swift
//  ProyectoFinal_Ricardo_V1
//
//  Created by Morello Santos Ricardo on 10/22/19.
//  Copyright © 2019 Morello Santos Ricardo. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
class SignUp2ViewController: UIViewController, UITextFieldDelegate{
    var donatarios = [Donatario]()
    var donatarioBaseDatos = Donatario()
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var context : NSManagedObjectContext
    required init?(coder aDecoder: NSCoder) {
        self.context = appDelegate.persistentContainer.viewContext
        super.init(coder: aDecoder)
    }
    @IBOutlet weak var outletBtnSignUp : UIButton!
    
    let alertController = UIAlertController(title: "Attention", message: "We ask this information so that we can filter donations next to you and to other users. DonAcción will not display or make use of sensitive information.", preferredStyle: .actionSheet)
    let signUpAlertController = UIAlertController(title: "Attention", message: "Thank you for signing up. Please login to continue.", preferredStyle: .actionSheet)
    
    func containsOnlyLetters(input: String) -> Bool {
        for chr in input {
            if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") && !(chr == "á" || chr == "é" || chr == "í" || chr == "ó" || chr == "ú") ) {
                return false
            }
        }
        return true
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "segueSignUp2Login"{
            let txtFields = [txtComplement, txtCityAreaDistrict, txtStreet, txtZipCode, txtName, txtCity]
            for txtField in txtFields{
                if txtField!.text!.isEmpty{
                    let textFieldValidationAlert = UIAlertController(title: "Atention", message: "Field \(txtField!.placeholder!) cannot be empty.", preferredStyle: .alert)
                    textFieldValidationAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    return false
                }
            }
        }
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        let textFieldValidationAlert = UIAlertController(title: "Atention", message: nil, preferredStyle: .alert)
        textFieldValidationAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        if textField.text!.isEmpty{
            textFieldValidationAlert.message = "The \(textField.placeholder!) field cannot be empty."
            present(textFieldValidationAlert, animated: true)
            return false
        }
        if textField.placeholder == "Name"{
            if !containsOnlyLetters(input: textField.text!){
                textFieldValidationAlert.message = "The \(textField.placeholder!) field can only contain letters."
                present(textFieldValidationAlert, animated: true)
                return false
            }
        }
        if textField.placeholder == "Zip code"{
            let geoCoder = CLGeocoder()
            let zipCode = textField.text!
            geoCoder.geocodeAddressString(zipCode){
                (placemarks, error) in

                if let placemark = placemarks?[0]{
                    self.txtCity.text = placemark.locality
                    self.txtCity.isEnabled = false
                    self.txtCityAreaDistrict.text = placemark.subLocality
                    self.txtCityAreaDistrict.isEnabled = false
                  
                }else{
                    print(error!)
                }
            }
        }
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        outletBtnSignUp.isEnabled = false
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        outletBtnSignUp.isEnabled = true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        addBackground()
        addGradient()
        txtName.underlined(textString: "Your name")
        txtZipCode.underlined(textString: "Zip code")
        txtStreet.underlined(textString: "Street")
        txtCityAreaDistrict.underlined(textString: "City Area/District")
        txtComplement.underlined(textString: "Complement")
        txtCity.underlined(textString: "City")
        txtZipCode.delegate = self
        txtName.delegate = self
        txtStreet.delegate = self
        txtCityAreaDistrict.delegate = self
        txtComplement.delegate = self
        
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    }
    @IBAction func btnSignUp(_ sender: Any) {

        
        donatarioBaseDatos.nombre = txtName.text!
        donatarioBaseDatos.zip_code = Int64(txtZipCode.text!)!
        donatarioBaseDatos.calle = txtStreet.text!
        donatarioBaseDatos.distrito = txtCityAreaDistrict.text!
        donatarioBaseDatos.complemento = txtComplement.text!
        donatarioBaseDatos.ciudad = txtCity.text!
        
        donatarios.append(donatarioBaseDatos)
        
        appDelegate.saveContext()
        signUpAlertController.addAction(UIAlertAction(title:"OK", style: .default, handler:  { action in self.performSegue(withIdentifier: "segueSignUp2Login", sender: self) }))
        
        signUpAlertController.popoverPresentationController?.sourceView = self.view
        signUpAlertController.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.size.width / 2.0, y: self.view.bounds.size.height / 2.0, width: 1.0, height: 1.0)
        
        self.present(signUpAlertController, animated: true, completion: nil)
    }
    @IBAction func btnMoreInfo(_ sender: Any) {
        
        alertController.popoverPresentationController?.sourceView = self.view
        alertController.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.size.width / 2.0, y: self.view.bounds.size.height / 2.0, width: 1.0, height: 1.0)
        
        self.present(alertController, animated: true, completion: nil)
    }
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtZipCode: UITextField!
    @IBOutlet weak var txtStreet: UITextField!
    @IBOutlet weak var txtCityAreaDistrict: UITextField!
    @IBOutlet weak var txtComplement: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    
    func addBackground(){
        let background = AddBackgroundImage(background: "signup2_background_image", bounds: self.view.bounds)
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
