//
//  PlayersListTableViewCell.swift
//  Pkkup
//
//  Created by Deepak on 10/10/14.
//  Copyright (c) 2014 Pkkup. All rights reserved.
//

import UIKit

class PlayersListTableViewCell: UITableViewCell {

    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var playerLocationLabel: UILabel!
    var player: PkkupPlayer! {
        willSet(newPlayer) {
            playerLabel.text = newPlayer.name!
            HTKImageUtils.sharedInstance.displayImageUrl(newPlayer.getGravatarImageUrl(), imageView: playerImageView)
            self.playerImageView.layer.cornerRadius = 5
            self.playerImageView.clipsToBounds = true
            playerLocationLabel.text = "\(newPlayer.city!), \(newPlayer.state!)"
        }

        didSet(oldPlayer) {
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
