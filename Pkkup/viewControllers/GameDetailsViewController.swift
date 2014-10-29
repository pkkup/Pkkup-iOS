//
//  GameDetailsViewController.swift
//  Pkkup
//
//  Copyright (c) 2014 Pkkup. All rights reserved.
//

import UIKit

class GameDetailsViewController: PkkupViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var placeButton: UIButton!
    @IBOutlet weak var playersListTable: UITableView!
    @IBOutlet weak var joinSegControl: UISegmentedControl!
    var themeColor = UIColor(hexString: "#0DB14B", alpha: 1)
    
    var playersConfirmed: [PkkupPlayer]!

    // TODO: wire outlets from views here
    var game: PkkupGame! {
        willSet(newGame) {
            self.navigationItem.title = newGame.sport?.name
        }
        didSet(oldGame) {
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        playersListTable.dataSource = self
        playersListTable.delegate = self
        playersListTable.rowHeight = UITableViewAutomaticDimension
        playersListTable.estimatedRowHeight = 120.0
        var location = game!.getLocation()
        timeLabel.text = game.getFormattedStartTime()
                self.placeButton.setTitle("\(location.name!),\n\(location.address!),\(location.city!) \(location.state!)", forState: UIControlState.Normal)
        self.placeButton.titleLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        playersConfirmed = game!.getPlayersConfirmed()
        joinSegControl.tintColor = self.themeColor
        self.navigationController?.navigationBar.barTintColor = self.themeColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPlaceButton(sender: UIButton) {
        var location = game.getLocation()
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        var locationDetailsViewController = storyboard.instantiateViewControllerWithIdentifier("LocationDetailsViewController") as LocationDetailsViewController
        locationDetailsViewController.view.layoutSubviews()
        locationDetailsViewController.location = location
        self.navigationController?.pushViewController(locationDetailsViewController, animated: true)
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playersConfirmed!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = playersListTable.dequeueReusableCellWithIdentifier("playersListTableViewCell") as PlayersListTableViewCell
        var player = playersConfirmed![indexPath.row]
        cell.player = player
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Players Going:"
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        var player = playersConfirmed![indexPath.row]
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        var playerDetailsViewController = storyboard.instantiateViewControllerWithIdentifier("PlayerDetailsViewController") as PlayerDetailsViewController
        playerDetailsViewController.view.layoutSubviews()
        playerDetailsViewController.player = player
        self.navigationController?.pushViewController(playerDetailsViewController, animated: true)
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        var player = playersConfirmed![indexPath.row]
        println("row selected..")
    }

    @IBAction func OnJoinSegmentedControlChange(sender: UISegmentedControl) {
        var selectedSegment = self.joinSegControl.selectedSegmentIndex
        NSLog("selectedSegmentIndex :\(selectedSegment)")
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation

}
