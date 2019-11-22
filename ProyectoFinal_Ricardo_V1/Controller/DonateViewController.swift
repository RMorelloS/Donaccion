//
//  DonateViewController.swift
//  ProyectoFinal_Ricardo_V1
//
//  Created by Morello Santos Ricardo on 10/22/19.
//  Copyright © 2019 Morello Santos Ricardo. All rights reserved.
//

import UIKit

class DonateViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return itensList.count
    }
    
    var donationsList : DonationsList!
    var donees = [Donatario]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addBackground()
        addGradient()
        addIconsToButtons()
        self.view.bringSubviewToFront(btnCamera)
        self.view.bringSubviewToFront(outletBtnAdd)
        donationsList = appDelegate.donationsList
        
        outletDescription.delegate = self
        outletDescription.underlined(textString: "Description")
        outletUIPicker.delegate = self
        outletUIPicker.dataSource = self
        
    }
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var outletDescription : UITextField!
    @IBOutlet weak var outletAmount : UISlider!
    @IBOutlet weak var outletBtnAdd: UIButton!
    @IBOutlet weak var outletBtnCancel: UIButton!
    @IBOutlet weak var outletDonationImage : UIImageView!
    @IBOutlet weak var outletUIPicker : UIPickerView!
    var donationCategory : String = "Clothes"
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    var itensList = ["Clothes", "Furniture", "Toys", "Appliances", "Electronics", "Books", "Computers", "Peripherals"]
    
    @IBAction func btnAdd(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let donationsTableViewController = storyboard.instantiateViewController(withIdentifier: "donationsTableViewController") as! DonationsTableViewController
        donationsTableViewController.tableView.reloadData()
        donationsTableViewController.topLabelText = donationCategory
        let donaccion = Donaccion(context: appDelegate.persistentContainer.viewContext)
        print(donationCategory)
        donaccion.categoria = donationCategory
        donaccion.descripcion = outletDescription.text!
        donaccion.correo_donatario = appDelegate.userEmail
        donaccion.cantidad = Int16(outletAmount.value)
        donationsList.allDonations.append(donaccion)
        donationsTableViewController.tableView.reloadData()
        appDelegate.saveContext()
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return itensList[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        donationCategory = itensList[row]
    }
    
    @IBOutlet weak var btnCamera: UIButton!
    
    func addIconsToButtons(){
        let addImage = UIImage(.add);
        outletBtnAdd.setImage(addImage, for: .normal)
        let cancelImage = UIImage(.stop);
        outletBtnCancel.setImage(cancelImage, for: .normal)
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
