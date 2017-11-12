//
//  FindAddressViewController.swift
//  AddressFinder
//
//  Created by Milica Jankovic on 10/30/17.
//  Copyright © 2017 Milica Jankovic. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MapKit


class FindAddressViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Outlets
    
    @IBOutlet var addressCustomView: MyCustomView!
    @IBOutlet var cityCustomView: MyCustomView!
    @IBOutlet var stateCustomView: MyCustomView!
    @IBOutlet var postalCustomView: MyCustomView!
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet var scrollView: UIScrollView!
  
    // MARK: View lifecycle
  
    var address = Address(title: "", locationName: "", coordinate: CLLocationCoordinate2D(latitude: 0.0 , longitude: 0.0))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTextFieldDelegate()
        
        changeTextFieldStyle()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:))))
      
    //  let backImage = UIImage(named: "img_back")
      
     // self.navigationController?.navigationBar.backIndicatorImage = backImage
      
     // self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
  
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
    
    @IBAction func backButtonTapAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func searchLocationButtonTapAction(_ sender: UIButton) {
      searchLocation(addressCustomView)
      searchLocation(cityCustomView)
      searchLocation(stateCustomView)
      searchLocation(postalCustomView)
      findAddress()
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
  
  func textFieldStyleWrongAddress(_ view: MyCustomView) {
    view.underlineView.backgroundColor = Constants.underlineColor.Error
    view.label.isHidden = false
    view.label.text = Constants.Message.wrongAddress
    
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
  
  
  func searchLocation(_ view: MyCustomView) -> Bool{
    
    switch  view {
    case view:
      
      if (view.textField.text?.isEmpty)! {
        textFieldStyleError(view)
        view.label.text = Constants.Message.error
        return false
      } else  {
        return checkCondition(view)
        
      }

    default:
      return false
    }
    
  }
  
    func checkCondition(_ view: MyCustomView) -> Bool{
      
        switch view {
          
        case addressCustomView:
            
            if (view.textField.text?.characters.count)! > 100 {
                textFieldStyleError(view)
                view.label.text = Constants.Message.addressError
              return false
              
            } else {
                textFieldStyleSuccess(view)
            return true
            
            }
            
        case cityCustomView:
            
            if (view.textField.text?.characters.count)! > 50 {
                textFieldStyleError(view)
                view.label.text = Constants.Message.cityError
              return false
            
            } else {
                textFieldStyleSuccess(view)
          return true
          
            }
            
            
        case stateCustomView:
            
            if (view.textField.text?.characters.count)! > 50 {
                textFieldStyleError(view)
                view.label.text = Constants.Message.stateError
              return false
            } else {
                textFieldStyleSuccess(view)
            return true
        
            }
            
            
            
        case postalCustomView:
            
            if (view.textField.text?.characters.count)! < 2 {
                textFieldStyleError(view)
                view.label.text = Constants.Message.postalErrorMin
              return false
            
            } else if (view.textField.text?.characters.count)! > 6 {
                textFieldStyleError(view)
                view.label.text = Constants.Message.postalErrorMax
              return false
            } else {
                textFieldStyleSuccess(view)
        return true
          }
            
        default: return false
          
        }
    }


  // MARK: Web service
    func findAddress() {
      if (searchLocation(addressCustomView)&&searchLocation(cityCustomView)&&searchLocation(stateCustomView)&&searchLocation(postalCustomView)) {
        
         guard let address = addressCustomView.textField.text else {return}
         guard let city = cityCustomView.textField.text else {return}
         guard let state = stateCustomView.textField.text else {return}
         guard let postal = postalCustomView.textField.text else {return}
         
         
      let parameters = ["Address": "\(address)",
        "City": "\(city)",
        "State": "\(state)",
        "Zip": "\(postal)",
        "f": "pjson"]
      
        let baseURL = "https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Locators/ESRI_Geocode_USA/GeocodeServer///findAddressCandidates"
        
       // let parameters = ["Address": "1156 High Street",
                       //  "City": "Santa Cruz",
                       //  "State": "CA",
                       // "Zip": "95064",
                       // "f": "pjson"]
        
      Alamofire.request(baseURL, method: .get, parameters: parameters).responseJSON { (responseData) in
        DispatchQueue.main.async( execute: {
          
          switch responseData.result {
            
          case .success:
            
            let json = JSON(responseData.result.value as Any)
            print(json)
            if !(json["candidates"].array?.isEmpty)! {
              let firstLocation =  json["candidates"][0].dictionary
              
              let address = firstLocation?["address"]?.string
              let lat = firstLocation?["location"]?["x"].doubleValue
              let long = firstLocation?["location"]?["y"].doubleValue
              let title = "Location"
              
              self.address = Address(title: address!,
                                     locationName: title,
                                     coordinate: CLLocationCoordinate2D(latitude: long! , longitude: lat!))
              
              self.performSegue(withIdentifier: "showLocation", sender: self.address)
            }
            else {
              self.textFieldStyleWrongAddress(self.addressCustomView)
              self.textFieldStyleWrongAddress(self.cityCustomView)
              self.textFieldStyleWrongAddress(self.stateCustomView)
              self.textFieldStyleWrongAddress(self.postalCustomView)
            }
            
          case .failure(let error):
            print("Error fetching location \(error)")
            break
          }
        })
        }
      }else {
          print("Error")
        }
        
    }
  
  // MARK:
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showLocation" {
      let mapViewController = segue.destination as! MapViewController
      mapViewController.address = self.address
      navigationItem.backBarButtonItem?.title = ""
      
    }
  }
}



