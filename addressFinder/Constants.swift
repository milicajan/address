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
    static let addressError = "Maximum 100"
    static let cityError = "Maximum 50"
    static let stateError = "Maximum 50"
    static let postalErrorMin = "Minimum 1 digit"
    static let postalErrorMax = "Maximum 6 digits"
  }
}
