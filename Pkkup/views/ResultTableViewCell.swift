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
    
    var pkkupGame : PkkupGame! {
        didSet(pkkupGame) {
            timeLabel.text = "8:45am 12th Apr, 2014 (Tuesday)"
            locationLabel.text = "Cuesta Park, 233 Grant Road"
            numPlayersLabel.text = "/10 Players"
            numRsvpLabel.text = "6"
            distanceLabel.text = "1.2 miles"
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
