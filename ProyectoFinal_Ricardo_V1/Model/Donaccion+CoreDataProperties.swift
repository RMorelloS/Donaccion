//
//  Donaccion+CoreDataProperties.swift
//  ProyectoFinal_Ricardo_V1
//
//  Created by Morello Santos Ricardo on 11/15/19.
//  Copyright © 2019 Morello Santos Ricardo. All rights reserved.
//
//

import Foundation
import CoreData


extension Donaccion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Donaccion> {
        return NSFetchRequest<Donaccion>(entityName: "Donaccion")
    }

    @NSManaged public var cantidad: Int16
    @NSManaged public var categoria: String?
    @NSManaged public var correo_donatario: String?
    @NSManaged public var descripcion: String?
    @NSManaged public var foto: NSData?
    @NSManaged public var donacionId: String?
    @NSManaged public var donatario: Donatario?

}
