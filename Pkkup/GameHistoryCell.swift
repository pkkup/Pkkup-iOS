//
//  GameHistoryCell.swift
//  Pkkup
//
//  Created by Kumar, Chandaraprakash on 10/13/14.
//  Copyright (c) 2014 Pkkup. All rights reserved.
//

import UIKit

class GameHistoryCell: UITableViewCell {

    @IBOutlet weak var sportNameLabel: UILabel!
    @IBOutlet weak var locationAddrLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var location: PkkupLocation! {
        willSet(newLocation) {
            self.sportNameLabel.text = "BasketBall"
            self.locationAddrLabel.text = "123 new st"
            self.timeLabel.text = "121"
        }
        didSet(oldLocation) {
            
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
