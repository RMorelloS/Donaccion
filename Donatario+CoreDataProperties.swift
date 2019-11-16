//
//  Donatario+CoreDataProperties.swift
//  ProyectoFinal_Ricardo_V1
//
//  Created by Morello Santos Ricardo on 11/15/19.
//  Copyright © 2019 Morello Santos Ricardo. All rights reserved.
//
//

import Foundation
import CoreData


extension Donatario {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Donatario> {
        return NSFetchRequest<Donatario>(entityName: "Donatario")
    }

    @NSManaged public var calle: String?
    @NSManaged public var complemento: String?
    @NSManaged public var contrasena: String?
    @NSManaged public var correo: String?
    @NSManaged public var distrito: String?
    @NSManaged public var nombre: String?
    @NSManaged public var zip_code: Int64
    @NSManaged public var ciudad: String?
    @NSManaged public var donaccion: Donaccion?

}
