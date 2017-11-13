//
//  ViewController.swift
//  addressFinder
//
//  Created by Milica Jankovic on 10/31/17.
//  Copyright © 2017 Milica Jankovic. All rights reserved.
//

import UIKit

class AddressFinderViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var findAddressButton: UIButton!
    @IBOutlet weak var bookmarkAddressButton: UIButton!
    
    // MARK: UIStatusBarStyle
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
