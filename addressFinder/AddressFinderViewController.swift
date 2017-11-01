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
    
    // View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleAttributes = [NSFontAttributeName: UIFont(name: "Oswald-Regular", size: 24)!]
        self.navigationController?.navigationBar.titleTextAttributes = titleAttributes
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
}
