//
//  BookmarksViewController.swift
//  addressFinder
//
//  Created by Milica Jankovic on 11/9/17.
//  Copyright © 2017 Milica Jankovic. All rights reserved.
//

import UIKit

class  BookmarksViewController: UITableViewController {
    
    // MARK: Action
    
    @IBAction func backButtonTappedAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: TableView DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath)
        return cell
    }
    
    
}
