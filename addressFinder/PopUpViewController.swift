//
//  PopUpViewController.swift
//  addressFinder
//
//  Created by Milica Jankovic on 11/14/17.
//  Copyright © 2017 Milica Jankovic. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    
    // MARK: Variables
    
  var indexPath: IndexPath!
  var locations: [Location] = []
  var tableView: UITableView!

  
  // MARK: Actions
    
  @IBAction func yesButtonTappedAction(_ sender: UIButton) {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //locations.remove(at: indexPath.row)
    //tableView.deleteRows(at: [indexPath], with: .automatic)
    let location = locations[indexPath.row]
    context.delete(location)
    (UIApplication.shared.delegate as! AppDelegate).saveContext()
    
    fetchTheData()
    tableView.reloadData()
    dismiss(animated: true, completion: nil)
  }

  
    @IBAction func noButtonTappedAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
  }
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
  
  
  func fetchTheData() {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    do {
      
      self.locations = try context.fetch(Location.fetchRequest())
    } catch {
      print("Fetching Faild")
    }
  }
  
}

// MARK: UIViewControllerTransitioningDelegate

extension PopUpViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return DimmingPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
