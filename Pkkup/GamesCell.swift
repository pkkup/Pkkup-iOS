//
//  GamesCell.swift
//  Pkkup
//
//  Created by Kumar, Chandaraprakash on 10/13/14.
//  Copyright (c) 2014 Pkkup. All rights reserved.
//

import UIKit

class GamesCell: UITableViewCell {

    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var gameLocationLabel: UILabel!
    @IBOutlet weak var gameTimeLabel: UILabel!

    var game: PkkupGame! {
        willSet(newGame) {
            gameNameLabel.text = newGame.sport?.name
            var location = newGame.getLocation()
            gameLocationLabel.text = "\(location.name!), \(location.city!), \(location.state!)"
            gameTimeLabel.text = newGame.getFormattedStartTime()
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
