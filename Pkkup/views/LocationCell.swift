//
//  LocationCell.swift
//  Pkkup
//
//  Created by Deepak on 10/28/14.
//  Copyright (c) 2014 Pkkup. All rights reserved.
//

import UIKit

class LocationCell: UITableViewCell {

    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var locationAddressLabel: UILabel!
    @IBOutlet weak var locationDistanceLabel: UILabel!
    
    var location: PkkupLocation! {
        willSet(newLocation) {
            locationNameLabel.text = newLocation.name
            locationAddressLabel.text = "\(newLocation.city!), \(newLocation.state!)"
            var distanceMiles = newLocation.getCurrentDistanceInMiles()
            if let distanceMiles = distanceMiles {
                var formattedDistance = String(format: "%.2f", distanceMiles)
                locationDistanceLabel.text = "\(formattedDistance) miles"
            } else {
                locationDistanceLabel.text = "? miles"
            }
        }
        didSet(oldGame) {
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
