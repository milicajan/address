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
  var locations: [Location] = []
  
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
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let address = self.address.title
    
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Location")
    let predicate = NSPredicate(format: "address == %@", address! )
    request.predicate = predicate
    request.fetchLimit = 1
    
    do{
      let count = try context.count(for: request)
      if(count == 0) {
        
        let location = Location(context: context)
        location.address = self.address.title
        location.city = self.address.city
        location.state = self.address.state
        location.postal = self.address.postal
        location.longitude = self.address.coordinate.longitude
        location.latitude = self.address.coordinate.latitude
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        locationIsSavedAlert()
        // performSegue(withIdentifier: "showMapView", sender: location)
      } else {
        locationExsitAlert()
        print("exists")
      }
    }
      
    catch let error as NSError {
      print("Could not fetch \(error), \(error.userInfo)")
    }
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
  
  func locationExsitAlert() {
    let alert = UIAlertController(title: "WORNING!", message: "Location already exists.",
                                  preferredStyle: .alert)
    
    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
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
