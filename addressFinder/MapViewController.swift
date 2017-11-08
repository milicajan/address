//
//  MapViewController.swift
//  addressFinder
//
//  Created by Milica Jankovic on 11/8/17.
//  Copyright © 2017 Milica Jankovic. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var mapView: MKMapView!
    
    var address = [Address]()
    
    // Variables
    
    let regionRadius: CLLocationDistance = 1000
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialLocation = CLLocation(latitude: 36.9788650000002 , longitude: -122.047288)
        
        zoomMapOnLocation(location: initialLocation)
        
        let address = Address(title: "900 HIGH ST",
                              locationName: "SANTA CRUZ, CA, 95060",
                              coordinate: CLLocationCoordinate2D(latitude: 36.9788650000002 , longitude: -122.047288))
    
        mapView.addAnnotation(address)
        mapView.delegate = self
        //fetchData()
       // mapView.addAnnotations(venues)
    }
    
    // MARK: CLLocation methode
    
    func zoomMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
        
    }
}


extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if let annotation = annotation as? Address {
        
        let reuseIdentifier = "pin"
        var view: MKPinAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? MKPinAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
        }
        return view
    }
        return nil
}
}
