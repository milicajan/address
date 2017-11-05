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
    
 // @IBOutlet var scrollView: UIScrollView!
  
  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    addressCustomView.textField.delegate = self
    cityCustomView.textField.delegate = self
    stateCustomView.textField.delegate = self
    postalCustomView.textField.keyboardType = UIKeyboardType.numberPad
    
   
    self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:))))
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
     }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
  }

  // MARK: Actions
  
  @IBAction func backButton() {
    dismiss(animated: true, completion: nil)
  }
  
    @IBAction func searchLocationButton(_ sender: UIButton) {
      
      //resetTextField(addressUnderlineView, addressLabel)
       // resetTextField(cityUnderlineView, cityLabel)
       // resetTextField(cityUnderlineView, cityLabel)
       // resetTextField(postalUnderlineView, postalLabel)
        
       // if
        //    if let city = cityTextField.text, !city.isEmpty {
        //        if let state = stateTextField.text, !state.isEmpty {
          //          if let postal = postalTextField.text, !postal.isEmpty, (postal.characters.count > 1 && postal.characters.count < 7)
                     //   {
                            
                      //      let fullAddress = ("\(address) \(city) \(state) \(postal)")
                      //      print("Address is \(fullAddress)")
                        
                   // } else {
                    //    setTextFieldWhenError(addressUnderlineView, addressLabel)
                    //    setTextFieldWhenError(cityUnderlineView, cityLabel)
                    //    setTextFieldWhenError(cityUnderlineView, cityLabel)
                    //    setTextFieldWhenError(postalUnderlineView, postalLabel)
                    //}
               // } else {
               //     setTextFieldWhenError(addressUnderlineView, addressLabel)
                //    setTextFieldWhenError(cityUnderlineView, cityLabel)
                //    setTextFieldWhenError(cityUnderlineView, cityLabel)
                //    setTextFieldWhenError(postalUnderlineView, postalLabel)
                    
             //   }
           // } else {
           //     setTextFieldWhenError(addressUnderlineView, addressLabel)
           ///     setTextFieldWhenError(cityUnderlineView, cityLabel)
             //   setTextFieldWhenError(cityUnderlineView, cityLabel)
             //   setTextFieldWhenError(postalUnderlineView, postalLabel)
                
          //  }
       // } else {
            
           // setTextFieldWhenError (addressUnderlineView, addressLabel)
           // setTextFieldWhenError(cityUnderlineView, cityLabel)
           /// setTextFieldWhenError(cityUnderlineView, cityLabel)
           // setTextFieldWhenError(postalUnderlineView, postalLabel)
       // }
    //}
    
    
  }
    
    // MARK: UITextFieldDelegate methode
    func textFieldDidBeginEditing(_ textField: UITextField) {
      addObservers()
    }
  
  
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      addressCustomView.textField.resignFirstResponder()
      cityCustomView.textField.resignFirstResponder()
      stateCustomView.textField.resignFirstResponder()
      postalCustomView.textField.resignFirstResponder()
      scrollView.contentInset = UIEdgeInsets.zero
      return true
        
    }
    /*func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }*/
    
    
    func didTapView(gesture: UITapGestureRecognizer) {
       view.endEditing(true)
      scrollView.contentInset = UIEdgeInsets.zero
  }
    
    
    // UIView and UILabel color setting methodes
    
   // func resetTextField(_ view: UIView, _ label: UILabel) {
        
   //     view.backgroundColor = UIColor(red: 0/255.0, green: 112.0/255.0, blue: 140.0/255.0, alpha: 1.0)
    //    label.isHidden = true
        
    //}
    
    //func setTextFieldWhenError(_ view: UIView, _ label: UILabel) {
      //  view.backgroundColor = UIColor(red: 225.0/255.0, green: 64.0/255.0, blue: 76.0/255.0, alpha: //1.0)
      //  label.isHidden = false
        
    //}
    
   // func setTextFieldWhenNumberError(_ view: UIView, _ label: UILabel) {
        
    //    view.backgroundColor = UIColor(red: 225.0/255.0, green: 64.0/255.0, blue: 76.0/255.0, alpha: //1.0)
    //    label.isHidden = false
    //}
    
  
  // MARK: Keyboard handaling notifications
    
  func addObservers() {
    NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: nil) {
      notification in
      self.keyboardWillShow(notification: notification)
    }
  }
  
  /// Move TextFields to keyboard. Step 6: Method to remove observers.
  func removeObservers() {
    NotificationCenter.default.removeObserver(self)
  }
  
  /// Move TextFields to keyboard. Step 4: Add method to handle keyboardWillShow notification, we're using this method to adjust scrollview to show hidden textfield under keyboard.
 
      func keyboardWillShow(notification: Notification) {
    guard let userInfo = notification.userInfo,
      let frame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
        return
    }
    let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height, right: 0)
    scrollView.contentInset = contentInset
  }
  
  /// Move TextFields to keyboard. Step 5: Method to reset scrollview when keyboard is hidden.
  func keyboardWillHide(notification: Notification) {
    scrollView.contentInset = UIEdgeInsets.zero
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

