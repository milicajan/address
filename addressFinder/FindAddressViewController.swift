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
    
    @IBOutlet var addressCustomView: MyCustomView!
    @IBOutlet var cityCustomView: MyCustomView!
    @IBOutlet var stateCustomView: MyCustomView!
    @IBOutlet var postalCustomView: MyCustomView!
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet var scrollView: UIScrollView!
  
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addressCustomView.textField.delegate = self
        cityCustomView.textField.delegate = self
        stateCustomView.textField.delegate = self
        postalCustomView.textField.delegate = self
        
        changeTextFieldStyle()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:))))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hideKeyboard()
        removeObservers()
    }
    
    // MARK: Actions
    
    @IBAction func backButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func searchLocationButton(_ sender: UIButton) {
        
        changeTextFieldStyle()
        
        
        if (addressCustomView.textField.text?.isEmpty)! {
            textFieldStyleError(addressCustomView)
        } else if (addressCustomView.textField.text?.characters.count)! > 100 {
            textFieldStyleError(addressCustomView)
        } else {
            textFieldStyleSuccess(addressCustomView)
        }
        
        if (cityCustomView.textField.text?.isEmpty)! {
            textFieldStyleError(cityCustomView)
        } else if (cityCustomView.textField.text?.characters.count)! > 50 {
            textFieldStyleError(cityCustomView)
            cityCustomView.label.text = Constants.Message.cityError
        } else {
            textFieldStyleSuccess(cityCustomView)
        }
        
        
        if (stateCustomView.textField.text?.isEmpty)! {
            textFieldStyleError(stateCustomView)
        } else if (stateCustomView.textField.text?.characters.count)! > 50 {
            textFieldStyleError(stateCustomView)
            stateCustomView.label.text = Constants.Message.stateError
        } else {
            textFieldStyleSuccess(stateCustomView)
        }
        
        
        if (postalCustomView.textField.text?.isEmpty)! {
            textFieldStyleError(postalCustomView)
        } else if ((postalCustomView.textField.text?.characters.count)! < 2) {
            textFieldStyleError(postalCustomView)
            postalCustomView.label.text = Constants.Message.postalErrorMin
        } else if ((postalCustomView.textField.text?.characters.count)! > 6){
            textFieldStyleError(postalCustomView)
            postalCustomView.label.text = Constants.Message.postalErrorMax
        } else {
            textFieldStyleSuccess(self.postalCustomView)
        }
    }



       /* if !((addressCustomView.textField.text?.isEmpty)! || (cityCustomView.textField.text?.isEmpty)! || (stateCustomView.textField.text?.isEmpty)! || (postalCustomView.textField.text?.isEmpty)!) {
            if ((postalCustomView.textField.text?.characters.count)! > 2 && (postalCustomView.textField.text?.characters.count)! < 7) {
                print("Find Location")
            } else {
                
                textFieldStyleError(addressCustomView)
                textFieldStyleError(cityCustomView)
                textFieldStyleError(stateCustomView)
                textFieldStyleNumberError(postalCustomView)
            }
        } else {
            textFieldStyleError(addressCustomView)
            textFieldStyleError(cityCustomView)
            textFieldStyleError(stateCustomView)
            textFieldStyleError(postalCustomView)
            
        }*/
        

    
    func textFieldShouldReturn() -> Bool {
        positionScrollView()
        return true
    }
    
    func didTapView(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
        positionScrollView()
    }
    
    
    // UIView and UILabel color setting methodes
    
    func textFieldStyleSuccess(_ view: MyCustomView) {
        view.underlineView.backgroundColor = Constants.underlineColor.Success
        view.label.isHidden = true
        
    }
    
    func textFieldStyleError(_ view: MyCustomView) {
        view.underlineView.backgroundColor = Constants.underlineColor.Error
        view.label.isHidden = false
        //selectView(view)
    }
    
    func changeTextFieldStyle() {
        
        textFieldStyleSuccess(addressCustomView)
        textFieldStyleSuccess(cityCustomView)
        textFieldStyleSuccess(stateCustomView)
        textFieldStyleSuccess(postalCustomView)
    }
    
    // MARK: Keyboard handaling notifications
    
    func addObservers() {
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: nil) {
            notification in
            self.keyboardWillShow(notification: notification)
        }
    }
    
    func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
            let frame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                return
        }
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height, right: 0)
        scrollView.contentInset = contentInset
    }
    
    func keyboardWillHide(notification: Notification) {
        scrollView.contentInset = UIEdgeInsets.zero
    }
    
    func positionScrollView() {
        scrollView.contentInset = UIEdgeInsets.zero
    }
    
    func hideKeyboard() {
        addressCustomView.textField.resignFirstResponder()
        cityCustomView.textField.resignFirstResponder()
        stateCustomView.textField.resignFirstResponder()
        postalCustomView.textField.resignFirstResponder()
    }
    
      /* func selectView(_ view: MyCustomView) -> String {
        
        
        switch view {
            
        case addressCustomView:
            
            view.label.text = "Maximum hellooo"
            
        case cityCustomView:
            view.label.text = Constants.Message.cityError
            
        case stateCustomView:
            view.label.text = Constants.Message.stateError
        }
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

/*func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
 
 let allowedCharacters = CharacterSet.decimalDigits
 let characterSet = CharacterSet(charactersIn: string)
 return allowedCharacters.isSuperset(of: characterSet)
 }*/
}*/
}
