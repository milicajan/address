//
//  BookmarkViewController.swift
//  addressFinder
//
//  Created by Milica Jankovic on 11/13/17.
//  Copyright © 2017 Milica Jankovic. All rights reserved.
//

import UIKit

class  BookmarkViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    struct TableViewCellIdentifiers {
        static let locationCell = "locationCell"
        
    }
    
    
    // MARK: Action
    
    @IBAction func backButtonTappedAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: "MyCustomCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableViewCellIdentifiers.locationCell)
        tableView.rowHeight = 120
    }
}


extension BookmarkViewController: UITableViewDataSource {
    
    
    //MARK: TableView DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.locationCell, for: indexPath) as! MyCustomCellTableViewCell
        
        cell.addressLabel.text = "Novosadsog sajma 2"
        cell.cityLabel.text = "Novi Sad"
        cell.stateLabel.text = "Serbia"
        cell.postalLabel.text = "21000"
        return cell
        
    }
}


