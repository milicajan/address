//
//  BookmarkViewController.swift
//  addressFinder
//
//  Created by Milica Jankovic on 11/13/17.
//  Copyright © 2017 Milica Jankovic. All rights reserved.
//

import UIKit
import CoreData

class  BookmarkViewController: UIViewController, UITableViewDataSource, OptionsButtonsDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var locations: [Location] = []
    
    // MARK: Action
    
    @IBAction func backButtonTappedAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: "MyCustomCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: Constants.TableViewCellIdentifiers.locationCell)
        tableView.rowHeight = 120
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchTheData()
        tableView.reloadData()
    }
    
    //MARK: TableView DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCellIdentifiers.locationCell, for: indexPath) as! MyCustomCellTableViewCell
        cell.delegate = self
        cell.indexPath = indexPath
        let location = locations[indexPath.row]
        
        cell.addressLabel.text = location.address
        cell.cityLabel.text = location.city
        cell.stateLabel.text = location.state
        cell.postalLabel.text = location.postal
      
    
        return cell
        
    }
    
    func fetchTheData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            
            locations = try context.fetch(Location.fetchRequest())
            
        } catch {
            print("Fetching Faild")
        }
    }
    
   
    
    func deleteButtonTapped(at index: IndexPath) {
        
        
        let popUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popUpID") as! PopUpViewController
        
        
       // self.addChildViewController(popUpVC)
       // popUpVC.view.frame = self.view.frame
        //self.view.addSubview(popUpVC.view)
        //popUpVC.didMove(toParentViewController: self)
        
        //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
       // let location = locations[index.row]
       // context.delete(location)
       // (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
       // do {
       //     locations = try context.fetch(Location.fetchRequest())
       // } catch {
       //     print("Fetching faild")
       // }
        
       // tableView.reloadData()
        
    //}
 }
}

