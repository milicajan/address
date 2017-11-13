//
//  Location+CoreDataProperties.swift
//  
//
//  Created by Milica Jankovic on 11/10/17.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var address: String
    @NSManaged public var city: String
    @NSManaged public var state: String
    @NSManaged public var postal: String
    @NSManaged public var longitude: Double
    @NSManaged public var latitude: Double

}
