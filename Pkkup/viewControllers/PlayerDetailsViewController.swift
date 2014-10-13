//
//  PlayerDetailsViewController.swift
//  Pkkup
//
//  Created by Jonathan Tsai on 10/4/14.
//  Copyright (c) 2014 Pkkup. All rights reserved.
//

import UIKit

class PlayerDetailsViewController: PkkupViewController {

    // TODO: wire outlets from views here
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerLocationLabel: UILabel!
    @IBOutlet weak var playerSportsLabel: UILabel!
    @IBOutlet weak var playerBioTextView: UITextView!
    @IBOutlet weak var gamesTableView: UITableView!


    var player: PkkupPlayer! {
        willSet(newPlayer) {
            self.playerNameLabel.text = newPlayer.firstName
        }

        didSet(oldPlayer) {
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        //customize player image
        self.playerImageView.layer.cornerRadius = 11.0
        self.playerImageView.layer.borderWidth = 1.0
        //self.playerImageView.layer.borderColor.borderColor = UIColor.blackColor()
        self.playerImageView.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
