//
//  MyCustomCellTableViewCell.swift
//  addressFinder
//
//  Created by Milica Jankovic on 11/13/17.
//  Copyright © 2017 Milica Jankovic. All rights reserved.
//

import UIKit

protocol OptionsButtonsDelegate {
    func deleteButtonTapped(at index:IndexPath)
}

class MyCustomCellTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var postalLabel: UILabel!
    
    var delegate:OptionsButtonsDelegate!
    @IBOutlet weak var deleteButton: UIButton!
   
    var indexPath:IndexPath!
    @IBAction func deleteLocationTapButton(_ sender: UIButton) {
        self.delegate?.deleteButtonTapped(at: indexPath)
        
    }
    
    
 @IBOutlet weak var showLocation: UIButton!

override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
}

override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
}
}

