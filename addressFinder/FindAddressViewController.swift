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
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addressTextField.delegate = self
        cityTextField.delegate = self
        stateTextField.delegate = self
        postalTextField.delegate = self
        postalTextField.keyboardType = UIKeyboardType.numberPad
        
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:))))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //addObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        addressTextField.resignFirstResponder()
        cityTextField.resignFirstResponder()
        stateTextField.resignFirstResponder()
        postalTextField.resignFirstResponder()
        
       // removeObservers()
    }
    
    
    // MARK: Actions
    
    @IBAction func searchLocationButton(_ sender: UIButton) {
        
        resetTextField(addressUnderlineView, addressLabel)
        resetTextField(cityUnderlineView, cityLabel)
        resetTextField(cityUnderlineView, cityLabel)
        resetTextField(postalUnderlineView, postalLabel)
        
        if let address = addressTextField.text, !address.isEmpty {
            if let city = cityTextField.text, !city.isEmpty {
                if let state = stateTextField.text, !state.isEmpty {
                    if let postal = postalTextField.text, !postal.isEmpty, (postal.characters.count > 1 && postal.characters.count < 7)
                        {
                            
                            let fullAddress = ("\(address) \(city) \(state) \(postal)")
                            print("Address is \(fullAddress)")
                        
                    } else {
                        setTextFieldWhenError(addressUnderlineView, addressLabel)
                        setTextFieldWhenError(cityUnderlineView, cityLabel)
                        setTextFieldWhenError(cityUnderlineView, cityLabel)
                        setTextFieldWhenError(postalUnderlineView, postalLabel)
                    }
                } else {
                    setTextFieldWhenError(addressUnderlineView, addressLabel)
                    setTextFieldWhenError(cityUnderlineView, cityLabel)
                    setTextFieldWhenError(cityUnderlineView, cityLabel)
                    setTextFieldWhenError(postalUnderlineView, postalLabel)
                    
                }
            } else {
                setTextFieldWhenError(addressUnderlineView, addressLabel)
                setTextFieldWhenError(cityUnderlineView, cityLabel)
                setTextFieldWhenError(cityUnderlineView, cityLabel)
                setTextFieldWhenError(postalUnderlineView, postalLabel)
                
            }
        } else {
            
            setTextFieldWhenError (addressUnderlineView, addressLabel)
            setTextFieldWhenError(cityUnderlineView, cityLabel)
            setTextFieldWhenError(cityUnderlineView, cityLabel)
            setTextFieldWhenError(postalUnderlineView, postalLabel)
        }
    }
    
    
    
    @IBAction func backButton() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: UITextFieldDelegate methode
    func textFieldDidBeginEditing(_ textField: UITextField) {
       scrollView.setContentOffset(CGPoint(x: 0,y:  100), animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0,y: 0), animated: true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        scrollView.setContentOffset(CGPoint(x: 0,y:  0), animated: true)
        return true
        
    }
    /*func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }*/
    
    
    func didTapView(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    // UIView and UILabel color setting methodes
    
    func resetTextField(_ view: UIView, _ label: UILabel) {
        
        view.backgroundColor = UIColor(red: 0/255.0, green: 112.0/255.0, blue: 140.0/255.0, alpha: 1.0)
        label.isHidden = true
        
    }
    
    func setTextFieldWhenError(_ view: UIView, _ label: UILabel) {
        view.backgroundColor = UIColor(red: 225.0/255.0, green: 64.0/255.0, blue: 76.0/255.0, alpha: 1.0)
        label.isHidden = false
        
    }
    
    func setTextFieldWhenNumberError(_ view: UIView, _ label: UILabel) {
        
        view.backgroundColor = UIColor(red: 225.0/255.0, green: 64.0/255.0, blue: 76.0/255.0, alpha: 1.0)
        label.isHidden = false
    }
    
    // MARK: NotificationCenter
    
   /* func addObservers() {
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: nil) {
            notification in
            self.keyboardWillShow(notification: notification)
        }
        
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillHide, object: nil, queue: nil) {
            notification in
            self.keyboardWillHide(notification: notification)
        }
    }
    
    func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    // MARK: Keyboard handaling notifications
    
    func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo, let frame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        
        scrollView.setContentOffset(CGPoint(x: 0,y:  250), animated: true)
    }
    
    
    func keyboardWillHide(notification: Notification) {
        scrollView.contentInset = UIEdgeInsets.zero
    }*/
 
    
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


// https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Locators/ESRI_Geocode_USA/GeocodeServer/findAddressCandidates?Address=1156+High+Street&City=Santa+Cruz&State=CA&Zip=95064&outFields=&outSR=&f=pjson
/*extension UITextField {
    func isNumeric(textField: UITextField) -> Bool {
        if (textField.text!.characters.count < 7 && textField.text!.characters.count > 1) {
            let numbers: Set<Character> = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
            return Set(self.text!.characters).isSubset(of: numbers)
        }
        return false
    }*/

