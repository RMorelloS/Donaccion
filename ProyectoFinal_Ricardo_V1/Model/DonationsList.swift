//
//  DonationsList.swift
//  ProyectoFinal_Ricardo_V1
//
//  Created by Morello Santos Ricardo on 11/15/19.
//  Copyright © 2019 Morello Santos Ricardo. All rights reserved.
//

import Foundation
import UIKit

class DonationsList{
    var allDonations = [Donaccion]()

    func donationsPerUserEmail(email : String) -> [Donaccion]{
        var donations = [Donaccion]()
        for donation in allDonations{
            if donation.correo_donatario == email{
                donations.append(donation)
            }
        }
        return donations
    }
    func createDonation(_ newCategory : String, _ newDescription:String, _ newAmount:Int, _ newDoneeEmail:String) -> Donaccion{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let newDonation = Donaccion(context: appDelegate.persistentContainer.viewContext)
        
        
        newDonation.categoria = newCategory
        newDonation.descripcion = newDescription
        newDonation.cantidad = Int16(newAmount)
        newDonation.correo_donatario = newDoneeEmail
        allDonations.append(newDonation)
        return newDonation
    }
    func deleteDonation(donation : Donaccion){
        if let donationIndex = allDonations.firstIndex(of: donation){
            allDonations.remove(at: donationIndex)
        }
        
    }
    func donationsPerCategory(category:String) -> [Donaccion]{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        var donationsInCategory = [Donaccion]()
        for donation in allDonations{
            if (donation.categoria == category) && (donation.correo_donatario != appDelegate.userEmail){
                donationsInCategory.append(donation)
            }
        }
        return donationsInCategory
    }
    // TODO: funcao store donation list.
    
    
}
