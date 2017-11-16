//
//  MyCustomCellTableViewCell.swift
//  addressFinder
//
//  Created by Milica Jankovic on 11/13/17.
//  Copyright © 2017 Milica Jankovic. All rights reserved.
//

import UIKit

// MARK: Protocol

protocol CellDelegate {
    func deleteButtonTapped(at index: IndexPath)
    func showLocationButtonTapped(at index: IndexPath)
}

class MyCustomCellTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var postalLabel: UILabel!
    
    // MARK: Variables
    
    var delegate: CellDelegate!
    var indexPath: IndexPath!
    
    
    // MARK: Actions
    
    @IBAction func deleteLocationTappedButton(_ sender: UIButton) {
        self.delegate?.deleteButtonTapped(at: indexPath)
        
    }
    
    @IBAction func showLocationOnMap(_ sender: UIButton) {
        self.delegate?.showLocationButtonTapped(at: indexPath)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

