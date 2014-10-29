//
//  LocationSportCell.swift
//  Pkkup
//
//  Copyright (c) 2014 Pkkup. All rights reserved.
//

import UIKit

class LocationSportCell: UITableViewCell {
    
    var locations: [PkkupLocation] = _LOCATIONS
    var sports: [PkkupSport] = _SPORTS

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var selectionImageView: UIImageView!

    
    var section: Int = -1
    var row: Int = -1
    var sectionExpanded = false
    var isRowSelected = false
    
    var locationSelected = 0
    var sportSelected = 0
    
    var createGameDelegate:CreateGameViewControllerDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.locationLabel.sizeToFit()
        
        if (section == 0) {
            self.locationLabel.text = locations[row].name!
            if (row == locationSelected) {
                isRowSelected = true
            } else {
                isRowSelected = false
            }
        }
        if (section == 1) {
            self.locationLabel.text = sports[row].name!
            if (row == sportSelected) {
                isRowSelected = true
            } else {
                isRowSelected = false
            }
        }
        
        if (sectionExpanded) {
            selectionImageView.hidden = true
        } else {
            selectionImageView.hidden = false
        }
    }

}
