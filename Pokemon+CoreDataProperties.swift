//
//  Pokemon+CoreDataProperties.swift
//  
//
//  Created by Ike Mattice on 8/31/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Pokemon {

    @NSManaged var isCaught: NSNumber?
    @NSManaged var dexNumber: NSNumber?
    @NSManaged var name: String?
    @NSManaged var sprite: String?

}
