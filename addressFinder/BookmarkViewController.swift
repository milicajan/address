//
//  BookmarkViewController.swift
//  addressFinder
//
//  Created by Milica Jankovic on 11/13/17.
//  Copyright © 2017 Milica Jankovic. All rights reserved.
//

import UIKit
import CoreData
import MapKit

class  BookmarkViewController: UIViewController, UITableViewDataSource, OptionsButtonsDelegate, PopUpViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var locations: [Location] = []
    var index: IndexPath!
        
    var fullAddress = Address(title: "", city: "", state: "", postal: "",  coordinate: CLLocationCoordinate2D(latitude: 0.0 , longitude: 0.0))
    
    // MARK: Action
    
    @IBAction func backButtonTappedAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        
        let cellNib = UINib(nibName: "MyCustomCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: Constants.TableViewCellIdentifiers.locationCell)
        tableView.rowHeight = 120
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        fetchTheData()
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
        self.index = indexPath
        
        cell.addressLabel.text = location.address
        cell.cityLabel.text = location.city
        cell.stateLabel.text = location.state
        cell.postalLabel.text = location.postal
        
       return cell
        
    }
    
  
  func fetchTheData() {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    do {
      
      self.locations = try context.fetch(Location.fetchRequest())
    } catch {
      print("Fetching Faild")
    }
  }
  
    // MARK: Delegate methodes
    
    func deleteButtonTapped(at index: IndexPath) {
       // self.index = index
        performSegue(withIdentifier: "showPopUp", sender: self.index)
      }
    
    func showLocationButtonTapped(at index: IndexPath) {
        
        let location = locations[index.row]
        let address = location.address
        let city = location.city
        let state = location.state
        let postal = location.postal
        let long = location.longitude
        let lat = location.latitude
        
        let fullAddress = Address(title: address!,
                                  city: city!,
                                  state: state!,
                                  postal: postal!,
                                  coordinate: CLLocationCoordinate2D(latitude: lat , longitude: long))
        
        self.fullAddress = fullAddress
        performSegue(withIdentifier: "showMap", sender: fullAddress)
            }
  
  func noButtonPressed(){
    dismiss(animated: true, completion: nil)
  }
  
  func  yesButtonPressed() {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let location = locations[index.row]
    context.delete(location)
    (UIApplication.shared.delegate as! AppDelegate).saveContext()
    
    do {
      self.locations = try context.fetch(Location.fetchRequest())
    } catch {
      print("Fetching faild")
    }
    
    tableView.reloadData()
    dismiss(animated: true, completion: nil)
  }
  
    // MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMap" {
            let mapViewController = segue.destination as! MapViewController
            mapViewController.address = fullAddress
        } else if segue.identifier == "showPopUp" {
      let popUpViewController = segue.destination as! PopUpViewController
      popUpViewController.delegate = self
    }
  }
       /* let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let location = locations[index.row]
        context.delete(location)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        do {
            self.locations = try context.fetch(Location.fetchRequest())
        } catch {
            print("Fetching faild")
        }
        
        tableView.reloadData()
    }*/}
