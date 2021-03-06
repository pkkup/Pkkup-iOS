//
//  ResultTableViewCell.swift
//  Pkkup
//
//  Copyright (c) 2014 Pkkup. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var numPlayersLabel: UILabel!
    @IBOutlet weak var numRsvpLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    var themeColor = UIColor(hexString: "#0DB14B", alpha: 1)

    var game : PkkupGame! {
        willSet(newGame) {
            timeLabel.text = newGame.getFormattedStartTime()
            var location = newGame.getLocation()
            locationLabel.text = "\(location.name!)\n\(location.address!)"
            numRsvpLabel.textColor = self.themeColor
            numRsvpLabel.text = String(newGame.getPlayersConfirmed().count) + " Going"

            var distanceMiles = location.getCurrentDistanceInMiles()
            if let distanceMiles = distanceMiles {
                var formattedDistance = String(format: "%.2f", distanceMiles)
                distanceLabel.text = "\(formattedDistance) miles"
            } else {
                distanceLabel.text = "? miles"
            }
            
            var bgColorView = UIView()
            bgColorView.backgroundColor = self.themeColor
            self.selectedBackgroundView = bgColorView
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
