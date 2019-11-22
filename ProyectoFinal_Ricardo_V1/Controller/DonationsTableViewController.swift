//
//  DonationsTableViewController.swift
//  ProyectoFinal_Ricardo_V1
//
//  Created by Morello Santos Ricardo on 11/15/19.
//  Copyright © 2019 Morello Santos Ricardo. All rights reserved.
//

import UIKit
import CoreData
import MessageUI
class DonationsTableViewController: UITableViewController, MFMailComposeViewControllerDelegate {
    
    
    
    
    @IBOutlet weak var topView : UIView!
    @IBOutlet weak var topLabel : UILabel!
    var colorTopView : UIColor = .orange
    var topLabelText : String = ""
    var donationsList : DonationsList!
    var donees = [Donatario]()
    private var context : NSManagedObjectContext
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        topView.backgroundColor = colorTopView
        topLabel.text = topLabelText
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        donationsList = appDelegate.donationsList
        tableView.reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }
    
    // MARK: - Table view data source
    required init?(coder aDecoder: NSCoder) {
        self.context = appDelegate.persistentContainer.viewContext
        super.init(coder: aDecoder)
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.tableView.cellForRow(at: indexPath) as! DonationTableViewCell
        let doneeEmail = cell.labelEmail.text!
        let doneeName = cell.labelPersonName.text!
        let donationName = cell.labelDescription.text!
        sendEmail(email: doneeEmail, name: doneeName, donation: donationName)
        
    }
    
    func sendEmail(email : String, name : String, donation : String) {
        if MFMailComposeViewController.canSendMail() {
            let message = "Hello," + name + "!\n I‘m interested in your donation " + donation + ". Please contact me as soon as you can.\nKind regards, " + fetchUserByEmail(email: appDelegate.userEmail)
            
            let composePicker = MFMailComposeViewController()
            composePicker.mailComposeDelegate = self
            //composePicker.delegate = self
            composePicker.setToRecipients([email])
            composePicker.setSubject(name)
            composePicker.setMessageBody(message, isHTML: false)
            self.present(composePicker, animated: true, completion: nil)
        }
        else {
            self.showerrorMessage()
        }
    }
    func showerrorMessage() {
        let alertMessage = UIAlertController(title: "could not sent email", message: "check if your device have email support!", preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title:"Ok", style: UIAlertAction.Style.default, handler: nil)
        alertMessage.addAction(action)
        self.present(alertMessage, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        print("Presionaron SEND para enviarl el email")
        controller.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return donationsList.donationsPerCategory(category: topLabelText).count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        do{
            donees = try context.fetch(Donatario.fetchRequest())
        }catch let error as NSError{
            print("could not fetch, \(error)")
        }
    }
    func fetchUserByEmail(email:String)->String{
        for donee in donees{
            if donee.correo == email{
                if let userName = donee.nombre{
                    return userName
                }else{
                    return ""
                }
            }
        }
        return ""
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppDonations", for: indexPath) as! DonationTableViewCell
        var donationsInCategory = donationsList.donationsPerCategory(category: topLabelText)
        
        let iten = donationsInCategory[indexPath.row]
        // Configure the cell...
        cell.labelPersonName.text = fetchUserByEmail(email: iten.correo_donatario!)
        cell.labelEmail.text = iten.correo_donatario
        cell.labelDescription.text = iten.descripcion
        
        
        cell.backgroundColor = UIColor.clear
        //      cell.textLabel?.text = item.nombre
        //      cell.detailTextLabel?.text = "$\(item.valorEnPesos)"
        return cell
    }
        // Configure the cell...

    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
