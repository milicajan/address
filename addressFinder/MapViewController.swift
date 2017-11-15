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
    
    //var managedObjectContext: NSManagedObjectContext!
  
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
    
    
    //func saveItem(itemToSave: Address){
       
     //   let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//
        
        //**Note:** Here we are providing the entityName **`Entity`** that we have added in the model
    //    let entity = NSEntityDescription.entity(forEntityName: "Location", in: context)
    //    let myItem = NSManagedObject(entity: entity!, insertInto: context)
        
     //   myItem.setValue(itemToSave, forKey: "address")
     //   do {
           // try context.save()
     //   }
       // catch{
       //     print("There was an error in saving data")
       //
    
    @IBAction func saveLocation(_ sender: UIButton) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        //let newLocation = NSEntityDescription.insertNewObject(forEntityName: "Location", into: context)
        
        let location = Location(context: context)
        location.address = address.title
        location.city = address.city
        location.state = address.state
        location.postal = address.postal
        location.longitude = address.coordinate.longitude
        location.latitude = address.coordinate.latitude
        
        
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        locationIsSaved()
        
    }
    
    func locationIsSaved() {
        let alert = UIAlertController(title: "SAVED!", message: "Your location is saved successfully!",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(action)
        present(alert, animated: true, completion:  nil)
    }
}

// MARK: Extension

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
