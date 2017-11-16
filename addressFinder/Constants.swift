//
//  Constants.swift
//  addressFinder
//
//  Created by Milica Jankovic on 11/5/17.
//  Copyright © 2017 Milica Jankovic. All rights reserved.
//
import UIKit

struct  Constants {
  
  struct  underlineColor {
    
    static let Error = UIColor(red: 225.0/255.0, green: 64.0/255.0, blue: 76.0/255.0, alpha: 1.0)
    static let Success = UIColor(red: 0/255.0, green: 112.0/255.0, blue: 140.0/255.0, alpha: 1.0)
  }
  
  struct  Message {
    static let error = "This field is mandatory"
    static let addressError = "You passed the limit.Input maximum 100 letters"
    static let cityError = "You passed the limit. Input maximum 50 letters"
    static let stateError = "You passed the limit. Input maximum 50 letters"
    static let postalErrorMin = "Not enough input. Minimum is 1 digit"
    static let postalErrorMax = "You passed the limit. Maximum limit is 6 digits"
    }
    
    struct TableViewCellIdentifiers {
        static let locationCell = "locationCell"
 }
    struct Identifier {
        static let mapSegue = "showMap"
        static let popUpSegue = "showPopUp"
        static let locationSegue = "showLocation"
    }
}
