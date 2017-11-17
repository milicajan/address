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
    
    // MARK: Init
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    // MARK: View life cycle
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.clear
    }
}

// MARK: UIViewControllerTransitioningDelegate

extension PopUpViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return DimmingPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            return BounceAnimationController()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideOutAnimationController()
    }
}

