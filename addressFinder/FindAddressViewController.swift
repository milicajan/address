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
        
        
  
    }
    
    @IBAction func backButton() {
        dismiss(animated: true, completion: nil)
    }
}


