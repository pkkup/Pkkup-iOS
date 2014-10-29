//
//  PlayerDetailsViewController.swift
//  Pkkup
//
//  Created by Jonathan Tsai on 10/4/14.
//  Copyright (c) 2014 Pkkup. All rights reserved.
//

import UIKit


class PlayerDetailsViewController: PkkupViewController, UITableViewDataSource, UITableViewDelegate {

    // TODO: wire outlets from views here
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerLocationLabel: UILabel!
    @IBOutlet weak var playerSportsLabel: UILabel!
    @IBOutlet weak var biographyLabel: UILabel!
    @IBOutlet weak var gamesTableView: UITableView!
    @IBOutlet weak var followUnfollowButton: UIButton!
    @IBOutlet weak var gamesSegment: UISegmentedControl!
    var selectedSegment: MyGamesSegmentedControlEnum = MyGamesSegmentedControlEnum.Upcoming
    
    var gamesConfirmed: [PkkupGame]!
    var gamesMaybe: [PkkupGame]!
    var gamesRecent: [PkkupGame]!
    var myLocations: [PkkupLocation]!
    var currentPlayer: PkkupPlayer!

    var player: PkkupPlayer! {
        willSet(newPlayer) {
            self.playerNameLabel.text = newPlayer.name!
            self.biographyLabel.text = newPlayer.biography!
            HTKImageUtils.sharedInstance.displayImageUrl(newPlayer.getGravatarImageUrl(), imageView: playerImageView)
            self.navigationItem.title = newPlayer.name!
            self.playerLocationLabel.text = "\(newPlayer.city!), \(newPlayer.state!)"
            self.playerSportsLabel.text = ", ".join(newPlayer.playerSports!)
            gamesConfirmed = newPlayer.getGamesConfirmed()
            gamesMaybe     = newPlayer.getGamesMaybe()
            myLocations    = newPlayer.getLocations()
        }

        didSet(oldPlayer) {
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        gamesTableView.dataSource = self
        gamesTableView.delegate = self
        gamesTableView.rowHeight = UITableViewAutomaticDimension
        gamesTableView.estimatedRowHeight = 80.0
        self.gamesSegment.tintColor = _THEME_COLOR
        //customize player image
        self.playerImageView.layer.cornerRadius = 5
        self.playerImageView.clipsToBounds = true
        
//        var tblView =  UIView(frame: CGRectZero)
//        gamesTableView.tableFooterView = tblView
//        gamesTableView.tableFooterView?.hidden = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onSegControlTap(sender: UISegmentedControl) {
        self.selectedSegment = MyGamesSegmentedControlEnum(rawValue: self.gamesSegment.selectedSegmentIndex)!
        NSLog("myGamesSegControl index :\(selectedSegment)")
        gamesTableView.reloadData()
    }

    @IBAction func onFollow(sender: AnyObject) {
        if(followUnfollowButton.titleLabel?.text == "Follow") {
            followUnfollowButton.setTitle("Unfollow", forState: UIControlState.Normal)
        } else {
            followUnfollowButton.setTitle("Follow", forState: UIControlState.Normal)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.selectedSegment {
        case .Upcoming:
            return self.gamesConfirmed.count
        case .Saved:
            return self.gamesMaybe.count
        case .Locations:
            return self.myLocations.count
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch self.selectedSegment {
        case .Upcoming:
            var cell = gamesTableView.dequeueReusableCellWithIdentifier("GamesCell") as GamesCell
            var game = self.gamesConfirmed[indexPath.row]
            cell.game = game
            return cell
        case .Saved:
            var cell = gamesTableView.dequeueReusableCellWithIdentifier("GamesCell") as GamesCell
            var game = self.gamesMaybe[indexPath.row]
            cell.game = game
            return cell
        case .Locations:
            var cell = gamesTableView.dequeueReusableCellWithIdentifier("LocationCell") as LocationCell
            var location = self.myLocations[indexPath.row]
            cell.location = location
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if ( self.selectedSegment != .Locations) {
            return
        }
        var location = self.myLocations[indexPath.row]
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        var locationDetailsViewController = storyboard.instantiateViewControllerWithIdentifier("LocationDetailsViewController") as LocationDetailsViewController
        locationDetailsViewController.view.layoutSubviews()
        locationDetailsViewController.location = location
        self.navigationController?.pushViewController(locationDetailsViewController, animated: true)
        
    }

}
