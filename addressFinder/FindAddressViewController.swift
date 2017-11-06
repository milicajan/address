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
        
      addTextFieldDelegate()
        
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
        searchLocation()
      }

  
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
    
  
    func changeTextFieldStyle() {
        
        textFieldStyleSuccess(addressCustomView)
        textFieldStyleSuccess(cityCustomView)
        textFieldStyleSuccess(stateCustomView)
        textFieldStyleSuccess(postalCustomView)
    }
  
  func addTextFieldDelegate() {
    addressCustomView.textField.delegate = self
    cityCustomView.textField.delegate = self
    stateCustomView.textField.delegate = self
    postalCustomView.textField.delegate = self
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


  // MARK: SearchLocation methodes
  
  func textFieldStyleError(_ view: MyCustomView) {
    view.underlineView.backgroundColor = Constants.underlineColor.Error
    view.label.isHidden = false
  }
  
  func searchLocation() {
    
    if (addressCustomView.textField.text?.isEmpty)! {
      textFieldStyleError(addressCustomView)
      addressCustomView.label.text = Constants.Message.error
    } else  {
      selectView(addressCustomView)
    }
    
    
    if (cityCustomView.textField.text?.isEmpty)! {
      textFieldStyleError(cityCustomView)
      cityCustomView.label.text = Constants.Message.error
    } else {
      selectView(cityCustomView)
    }
    
    
    if (stateCustomView.textField.text?.isEmpty)! {
      textFieldStyleError(stateCustomView)
      stateCustomView.label.text = Constants.Message.error
    } else {
      selectView(stateCustomView)
    }
    
    if (postalCustomView.textField.text?.isEmpty)! {
      textFieldStyleError(postalCustomView)
      postalCustomView.label.text = Constants.Message.error
    } else {
      selectView(postalCustomView)
    }
    
  }
  
  func selectView(_ view: MyCustomView){
    
    switch view {
      
    case addressCustomView:
      
      if (view.textField.text?.characters.count)! > 100 {
        textFieldStyleError(view)
        view.label.text = Constants.Message.addressError
      } else {
        textFieldStyleSuccess(view)
      }
      
    case cityCustomView:
      
      if (view.textField.text?.characters.count)! > 70 {
        textFieldStyleError(view)
        view.label.text = Constants.Message.cityError
      } else {
        textFieldStyleSuccess(view)
      }
      
      
    case stateCustomView:
      
      if (view.textField.text?.characters.count)! > 50 {
        textFieldStyleError(view)
        view.label.text = Constants.Message.stateError
      } else {
        textFieldStyleSuccess(view)
      }
      
      
      
    case postalCustomView:
      
      if (view.textField.text?.characters.count)! < 2 {
        textFieldStyleError(view)
        view.label.text = Constants.Message.postalErrorMin
      } else if (view.textField.text?.characters.count)! > 6 {
        textFieldStyleError(view)
        view.label.text = Constants.Message.postalErrorMax
      } else {
        textFieldStyleSuccess(view)
      }
      
    default:
      break
    }
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
 */
