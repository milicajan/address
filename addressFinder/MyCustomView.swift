//
//  MyCustomView.swift
//  addressFinder
//
//  Created by Milica Jankovic on 11/5/17.
//  Copyright © 2017 Milica Jankovic. All rights reserved.
//

import UIKit

@IBDesignable class MyCustomView: UIView {
  
  var view: UIView!
  
  @IBOutlet var textField: UITextField!
  @IBOutlet var underlineView: UIView!
  @IBOutlet var label: UILabel!
  
  
  @IBInspectable var myPlaceholder: String?
    {
    get
    {
      return textField.placeholder
    }
    set(myPlaceholder){
      textField.placeholder = myPlaceholder
    }
  }
  

  @IBInspectable var myUnderlineColor: UIColor? {
    get{
      return underlineView.backgroundColor
    }
    set(myUnderlineColor){
      underlineView.backgroundColor = myUnderlineColor
    }
  }
  
  @IBInspectable var myLabel: String?
    {
    get{
      return label.text
    }
    set(myLabel)
    {
      label.text = myLabel
    }
  }

override init(frame: CGRect)
  {
    super.init(frame: frame)
    setup()
  }
  
  required init(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)!
    setup()
  }
  
  func setup()
  {
    view = loadViewFromNib()
    view.frame = bounds
    view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    addSubview(view)
  }
  
  func loadViewFromNib() -> UIView
  {
    let bundle = Bundle(for:type(of: self))
    let nib = UINib(nibName: "MyCustomView", bundle: bundle)
    let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
    return view
  }
}

