//
//  PopUpViewController.swift
//  addressFinder
//
//  Created by Milica Jankovic on 11/14/17.
//  Copyright © 2017 Milica Jankovic. All rights reserved.
//

import UIKit
import CoreData

class PopUpViewController: UIViewController {
    
    var cell = MyCustomCellTableViewCell()
    
      @IBAction func yesButtonTapAction(_ sender: UIButton) {
        
        }
    
    @IBAction func noButtonTappedAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
extension PopUpViewController: UIViewControllerTransitioningDelegate {
  func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
    return DimmingPresentationController(presentedViewController: presented, presenting: presenting)
  }
}
