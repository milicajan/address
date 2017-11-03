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
    @IBOutlet weak var postalErrorLabel: UILabel!
    
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var addressUnderlineView: UIView!
    @IBOutlet weak var cityUnderlineView: UIView!
    @IBOutlet weak var stateUnderlineView: UIView!
    @IBOutlet weak var postalUnderlineView: UIView!
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addressTextField.delegate = self
        cityTextField.delegate = self
        stateTextField.delegate = self
        postalTextField.delegate = self
        
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(FindAddressViewController.dismissKeyboard)))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        dismissKeyboard()
    }
    
    
    @IBAction func searchLocationButton(_ sender: UIButton) {
        
        resetTextField()
        
        if let address = addressTextField.text, !address.isEmpty {
            if let city = cityTextField.text, !city.isEmpty {
                if let state = stateTextField.text, !state.isEmpty {
                    if let postal = postalTextField.text, !postal.isEmpty {
                        if (postal.characters.count > 1 && postal.characters.count < 7) {
                            
                            
                            let fullAddress = ("\(address) \(city) \(state) \(postal)")
                            print("Address is \(fullAddress)")
                        }
                    } else {
                        setTextFieldWhenError()
                    }
                } else {
                    setTextFieldWhenError()
                }
            } else {
                setTextFieldWhenError()
            }
        } else {
            
            setTextFieldWhenError()
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
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.addressTextField.resignFirstResponder()
        self.cityTextField.resignFirstResponder()
        self.stateTextField.resignFirstResponder()
        self.postalTextField.resignFirstResponder()
        return true
        
    }
    
    func dismissKeyboard(){
        self.addressTextField.resignFirstResponder()
        self.cityTextField.resignFirstResponder()
        self.stateTextField.resignFirstResponder()
        self.postalTextField.resignFirstResponder()
    }
    
    
    // UIView and UILabel color setting methodes
    
    func resetTextField() {
        
        addressUnderlineView.backgroundColor = UIColor(red: 0/255.0, green: 112.0/255.0, blue: 140.0/255.0, alpha: 1.0)
        cityUnderlineView.backgroundColor = UIColor(red: 0/255.0, green: 112.0/255.0, blue: 140.0/255.0, alpha: 1.0)
        stateUnderlineView.backgroundColor = UIColor(red: 0/255.0, green: 112.0/255.0, blue: 140.0/255.0, alpha: 1.0)
        postalUnderlineView.backgroundColor = UIColor(red: 0/255.0, green: 112.0/255.0, blue: 140.0/255.0, alpha: 1.0)
        
        addressLabel.isHidden = true
        cityLabel.isHidden = true
        stateLabel.isHidden = true
        postalLabel.isHidden = true
        postalErrorLabel.isHidden = true
        
    }
    
    func setTextFieldWhenError() {
        addressUnderlineView.backgroundColor = UIColor(red: 225.0/255.0, green: 64.0/255.0, blue: 76.0/255.0, alpha: 1.0)
        cityUnderlineView.backgroundColor = UIColor(red: 225.0/255.0, green: 64.0/255.0, blue: 76.0/255.0, alpha: 1.0)
        stateUnderlineView.backgroundColor = UIColor(red: 225.0/255.0, green: 64.0/255.0, blue: 76.0/255.0, alpha: 1.0)
        postalUnderlineView.backgroundColor = UIColor(red: 225.0/255.0, green: 64.0/255.0, blue: 76.0/255.0, alpha: 1.0)
        
        addressLabel.isHidden = false
        cityLabel.isHidden = false
        stateLabel.isHidden = false
        postalLabel.isHidden = false
    }
    
    // MARK: Web service
    //func findAddress(fullAddress: String!, withCompletionHandlet completionHandler: ((_ status: String, _ success: Bool) -> Void)) {
    //   let baseURLGeocode = "https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Locators/ESRI_Geocode_USA/GeocodeServer/findAddressCandidates/json?"
    //  var addressResults: Dictionary<NSObject, AnyObject>!
    //  var fetchedAddressLongitude: Double!
    // var fetchedAddressLatitude: Double!
    
    // if let findAddress = fullAddress {
    //     var geocodeURLString = baseURLGeocode + "Address=" + findAddress
    
    // }
}

// https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Locators/ESRI_Geocode_USA/GeocodeServer/findAddressCandidates?Address=1156+High+Street&City=Santa+Cruz&State=CA&Zip=95064&outFields=&outSR=&f=pjson

