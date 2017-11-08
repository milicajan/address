//
//  File.swift
//  addressFinder
//
//  Created by Milica Jankovic on 11/8/17.
//  Copyright © 2017 Milica Jankovic. All rights reserved.
//

import MapKit
import SwiftyJSON

class Address: NSObject, MKAnnotation {
    let title: String?
    var locationName: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String,locationName: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
    
    func from(json: JSON) -> Address? {
        
        var title: String
        if let unwrappedTitle = json["address"].string {
            title = unwrappedTitle
        } else {
            title = ""
        }
        
        let locationName = json["address"].string
        let lat = json["location"]["y"].doubleValue
        let long = json["location"]["x"].doubleValue
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
        return Address(title: title, locationName: locationName!, coordinate: coordinate)
    }
}
