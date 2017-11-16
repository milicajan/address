//
//  PopUpViewController.swift
//  addressFinder
//
//  Created by Milica Jankovic on 11/14/17.
//  Copyright © 2017 Milica Jankovic. All rights reserved.
//

import UIKit

// MARK: Protocol

protocol PopUpViewDelegate {
    func noButtonPressed()
    func yesButtonPressed()
}

class PopUpViewController: UIViewController {
    
    // MARK: Variables
    
    var delegate: PopUpViewDelegate!
    
    // MARK: Actions
    
    @IBAction func yesButtonTappedAction(_ sender: UIButton) {
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
    
}

// MARK: UIViewControllerTransitioningDelegate

extension PopUpViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return DimmingPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
