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
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var numPlayersLabel: UILabel!
    
    var game: PkkupGame! {
        willSet(newGame) {
            self.sportNameLabel.text = newGame.sport?.name
            self.timeLabel.text = newGame.getFormattedStartTime()
            self.numPlayersLabel.text = "Num Players: \(String(newGame.getPlayersConfirmed().count))"
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
