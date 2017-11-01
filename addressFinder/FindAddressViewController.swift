//
//  FindAddressViewController.swift
//  AddressFinder
//
//  Created by Milica Jankovic on 10/30/17.
//  Copyright © 2017 Milica Jankovic. All rights reserved.
//

import UIKit


class FindAddressViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var postalTextField: UITextField!
    
    @IBOutlet weak var searchButton: UIButton!
    
    // View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       self.navigationController?.navigationBar.titleTextAttributes  = [NSFontAttributeName: UIFont(name: "Oswald-Regular", size: 24)!]
       self.navigationController?.navigationBar.titleTextAttributes  = [NSForegroundColorAttributeName: UIColor(red: 228.0/255.0, green: 239.0/255.0, blue: 242.0/255.0, alpha: 1.0)]
        
    }
    
    @IBAction func searchLocationButton(_ sender: UIButton) {
        
        
        //let authStatus = C
        //locationManager.delegate = self
        // locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // locationManager.startUpdatingLocation()
        
        //let geoCoder = CLGeocoder()
        //var coordinates: CLLocationCoordinate2D?
        
        //if let address = addressTextField.text {
        // if let city = cityTextField.text {
        //   if let state = stateTextField.text {
        //  if let postal = postalTextField.text {
        
        //   let fullAddress = "\(address), \(city), \(state), \(postal)"
        
        // geoCoder.geocodeAddressString(fullAddress, completionHandler: {(placemarks: [CLPlacemark]?, error: Error?) -> Void in
        //     if let placemark = placemarks?[0] {
        //      let location = placemark.location
        //     coordinates = location!.coordinate
        
        
        //  }
        //  })
        // }
        // }
        //}
        //} else {
        //searchButton.isEnabled = false
        //}
        //}
    }
    
    @IBAction func backButton() {
        dismiss(animated: true, completion: nil)
    }
}


