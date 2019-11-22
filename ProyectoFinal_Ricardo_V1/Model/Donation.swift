//
//  Donation.swift
//  ProyectoFinal_Ricardo_V1
//
//  Created by Morello Santos Ricardo on 11/15/19.
//  Copyright © 2019 Morello Santos Ricardo. All rights reserved.
//

import Foundation

class Donation : NSObject{
    var category:String
    var donationDescription:String
    var amount:Int
    var doneeEmail:String
    var donationId:String
    init(newCategory : String, newDescription:String, newAmount:Int, newDoneeEmail:String) {
        self.category=newCategory
        self.donationDescription=newDescription
        self.amount=newAmount
        self.doneeEmail=newDoneeEmail
        self.donationId=UUID().uuidString.components(separatedBy: "-").first!
    }
}
