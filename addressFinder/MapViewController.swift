//
//  MapViewController.swift
//  addressFinder
//
//  Created by Milica Jankovic on 11/8/17.
//  Copyright © 2017 Milica Jankovic. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class MapViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var bookmarkButton: UIButton!
    
    // Variables
    
    let regionRadius: CLLocationDistance = 1000
    var address = Address(title: "", city: "", state: "", postal: "",  coordinate: CLLocationCoordinate2D(latitude: 0.0 , longitude: 0.0))
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookmarkButton.layer.cornerRadius = 25.0
        
        zoomMapOnLocation(location: address)
        mapView.addAnnotation(address)
        mapView.delegate = self
    }
    
    // MARK: Actions
    
    @IBAction func saveLocation(_ sender: UIButton) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        
        let location = Location(context: context)
        location.address = address.title
        location.city = address.city
        location.state = address.state
        location.postal = address.postal
        location.longitude = address.coordinate.longitude
        location.latitude = address.coordinate.latitude
        
        
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        bookmarkButton.isEnabled = false
        locationIsSavedAlert()
        performSegue(withIdentifier: "showMapView", sender: location)
        
    }
    
    // MARK: CLLocation methode
    
    func zoomMapOnLocation(location: Address) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        
    }
    
    // MARK: Alert methode
    
    func locationIsSavedAlert() {
        let alert = UIAlertController(title: "SAVED!", message: "Your location is saved successfully!",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(action)
        present(alert, animated: true, completion:  nil)
    }
}

// MARK: MapViewDelegate

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
