//
//  FindAddressViewController.swift
//  AddressFinder
//
//  Created by Milica Jankovic on 10/30/17.
//  Copyright © 2017 Milica Jankovic. All rights reserved.
//

import UIKit


class FindAddressViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Outlets
    
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var postalTextField: UITextField!
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var postalLabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var addressUnderlineView: UIView!
    @IBOutlet weak var cityUnderlineView: UIView!
    @IBOutlet weak var stateUnderlineView: UIView!
    @IBOutlet weak var postalUnderlineView: UIView!
    
    // View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.titleTextAttributes  = [NSFontAttributeName: UIFont(name: "Oswald-Regular", size: 24)!]
        self.navigationController?.navigationBar.titleTextAttributes  = [NSForegroundColorAttributeName: UIColor(red: 228.0/255.0, green: 239.0/255.0, blue: 242.0/255.0, alpha: 1.0)]
        addressTextField.delegate = self
        cityTextField.delegate = self
        stateTextField.delegate = self
        postalTextField.delegate = self
        
    }
    
    @IBAction func searchLocationButton(_ sender: UIButton) {
        
        addressLabel.isHidden = true
        cityLabel.isHidden = true
        stateLabel.isHidden = true
        postalLabel.isHidden = true
        addressUnderlineView.backgroundColor = UIColor(red: 0/255.0, green: 112.0/255.0, blue: 140.0/255.0, alpha: 1.0)
        cityUnderlineView.backgroundColor = UIColor(red: 0/255.0, green: 112.0/255.0, blue: 140.0/255.0, alpha: 1.0)
        stateUnderlineView.backgroundColor = UIColor(red: 0/255.0, green: 112.0/255.0, blue: 140.0/255.0, alpha: 1.0)
        postalUnderlineView.backgroundColor = UIColor(red: 0/255.0, green: 112.0/255.0, blue: 140.0/255.0, alpha: 1.0)
        
        
        if let address = addressTextField.text, !address.isEmpty {
            if let city = cityTextField.text, !city.isEmpty {
                if let state = stateTextField.text, !state.isEmpty {
                    if let postal = postalTextField.text, !postal.isEmpty, postal.characters.count == 6 {
                        
                        let fullAddress = ("\(address) \(city) \(state) \(postal)")
                        print("Address is \(fullAddress)")
                    }
                    else {
                        postalUnderlineView.backgroundColor = UIColor(red: 225.0/255.0, green: 64.0/255.0, blue: 76.0/255.0, alpha: 1.0)
                        postalLabel.isHidden = false
                    }
                } else {
                    stateUnderlineView.backgroundColor = UIColor(red: 225.0/255.0, green: 64.0/255.0, blue: 76.0/255.0, alpha: 1.0)
                    stateLabel.isHidden = false
                }
            } else {
                cityUnderlineView.backgroundColor = UIColor(red: 225.0/255.0, green: 64.0/255.0, blue: 76.0/255.0, alpha: 1.0)
                cityLabel.isHidden = false
            }
        } else {
            addressUnderlineView.backgroundColor = UIColor(red: 225.0/255.0, green: 64.0/255.0, blue: 76.0/255.0, alpha: 1.0)
            addressLabel.isHidden = false
        }
    }
    
    @IBAction func backButton() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: UITextFieldDelegate methode
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.isFirstResponder == true {
            textField.placeholder = ""
        }
    }
}

