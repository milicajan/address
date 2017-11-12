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
    
    @IBOutlet weak var bookmarkButton: UIButton!
    // MARK: Actions
    
     // Variables
    
    let regionRadius: CLLocationDistance = 1000
    var address = Address(title: "", locationName: "", coordinate: CLLocationCoordinate2D(latitude: 0.0 , longitude: 0.0))
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookmarkButton.layer.cornerRadius = 25.0
        
        zoomMapOnLocation(location: address)
        
        mapView.addAnnotation(address)
        mapView.delegate = self
    
    }
    
    // MARK: CLLocation methode
    
    func zoomMapOnLocation(location: Address) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
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
            }
            return view
        }
        return nil
    }
}
