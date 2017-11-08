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
    
    @IBAction func backButtonTapAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func searchLocationButtonTapAction(_ sender: UIButton) {
        searchLocation()
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
            checkCondition(addressCustomView)
        }
        
        
        if (cityCustomView.textField.text?.isEmpty)! {
            textFieldStyleError(cityCustomView)
            cityCustomView.label.text = Constants.Message.error
        } else {
            checkCondition(cityCustomView)
        }
        
        
        if (stateCustomView.textField.text?.isEmpty)! {
            textFieldStyleError(stateCustomView)
            stateCustomView.label.text = Constants.Message.error
        } else {
            checkCondition(stateCustomView)
        }
        
        if (postalCustomView.textField.text?.isEmpty)! {
            textFieldStyleError(postalCustomView)
            postalCustomView.label.text = Constants.Message.error
        } else {
            checkCondition(postalCustomView)
        }
        
    }
    
    func checkCondition(_ view: MyCustomView) {
        
        switch view {
            
        case addressCustomView:
            
            if (view.textField.text?.characters.count)! > 100 {
                textFieldStyleError(view)
                view.label.text = Constants.Message.addressError
            } else {
                textFieldStyleSuccess(view)
            }
            
        case cityCustomView:
            
            if (view.textField.text?.characters.count)! > 50 {
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
    

    
    // MARK: Web service
    func findAddress() {
        
        /*var addressResults: Dictionary<NSObject, AnyObject>!
         var fetchedAddressLongitude: Double!
         var fetchedAddressLatitude: Double!
         */
        
        /* guard let address = addressCustomView.textField.text else {return}
         guard let  city = cityCustomView.textField.text else {return}
         guard let state = stateCustomView.textField.text else {return}
         guard let  postal = postalCustomView.textField.text else {return}
         
         
         let parameters = ["Address": "\(address)",
         "City": "\(city)",
         "State": "\(state)",
         "Zip": "\(postal)",
         "f": "pjson"] */
        
        let baseURL = "https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Locators/ESRI_Geocode_USA/GeocodeServer/findAddressCandidates"
        
        let parameters = ["Address": "1156 High Street",
                          "City": "Santa Cruz",
                          "State": "CA",
                          "Zip": "95064",
                          "f": "pjson"]
        
        Alamofire.request(baseURL, method: .get, parameters: parameters).responseJSON { (responseData) in
            
            if((responseData.result.value) != nil) {
                let json = JSON(responseData.result.value!)
                print(json)
                //for result in json["candidates"].arrayValue {
                  //  let address = result["address"].string
                    //let long = result["location"]["x"].doubleValue
                    //let lot = result["location"]["y"].doubleValue
        } else {
                print("error")
            }
        }
    }
}

/*8  Alamofire.request(baseURL, method: .get, parameters:parameters).responseJSON { (response) in
            
            NSLog("response =  \(response)")
            
            switch response.result {
                
            case .success:
                
                guard let result = response.result.value else {
                    NSLog("Result value in response in nil")
                    return
                }
                
                print(result)
                let json = result as? [String: Any]
                guard let array = json?["candidates"] as? [[String: Any]] else {
                    print("Expected 'canditates' array")
                    return
                }
                
                if let location =  array[0]["location"] as? [String: Double] {
                let longitude = location["x"]!
                let latitude = location["y"]!
                print("Longitude is \(longitude) and latitude \(latitude)")
                } else {
                    print("Expected longitude and latitude")
                }
                
            case .failure(let error):
                print("Error fetching location \(error)")
                break
            }
        }
    }
    
    // MARK:
  //  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //    if segue.identifier == "ShowLocation"
   //     {
      //
       //     let mapViewController = se
        }
    //}
//}

/*https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Locators/ESRI_Geocode_USA/GeocodeServer/findAddressCandidates?Address=1156+High+Street&City=Santa+Cruz&State=CA&Zip=95064&f=pjson
 
 }
/* {
"spatialReference" : {
    "wkid" : 4326 } ,
"candidates" : [
{
"address" : "900 HIGH ST, SANTA CRUZ, CA, 95060",
"location" : {
"x" : -122.04728799999981,
"y" : 36.978865000000155
},
"score" : 40,
"attributes" : {

}
},
{
"address" : "925 HIGH ST, SANTA CRUZ, CA, 95060",
"location" : {
"x" : -122.04605499999991,
"y" : 36.97797700000018
},
"score" : 40,
"attributes" : {

}
}*/
*/*/
