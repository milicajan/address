//
//  PopUpViewController.swift
//  addressFinder
//
//  Created by Milica Jankovic on 11/14/17.
//  Copyright © 2017 Milica Jankovic. All rights reserved.
//

import UIKit

protocol PopUpViewDelegate {
  func noButtonPressed()
  func yesButtonPressed()
}

class PopUpViewController: UIViewController {
  
  
  var delegate: PopUpViewDelegate!
  @IBAction func yesButtonTapAction(_ sender: UIButton) {
    self.delegate?.yesButtonPressed()
  }
  
  @IBAction func noButtonTappedAction(_ sender: UIButton) {
    self.delegate?.noButtonPressed()
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
