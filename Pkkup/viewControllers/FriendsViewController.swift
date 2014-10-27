//
//  FriendsViewController.swift
//  Pkkup
//
//  Created by Deepak on 10/19/14.
//  Copyright (c) 2014 Pkkup. All rights reserved.
//

import UIKit

enum FriendsSegmentedControlEnum: Int {
    case Following = 0
    case Followers = 1
}

class FriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var friendsTableView: UITableView!
    
    @IBOutlet weak var friendsSegControl: UISegmentedControl!
    
    var playersFollowing: [PkkupPlayer]!
    var playersFollowers: [PkkupPlayer]!
    var currentPlayer: PkkupPlayer!
    var selectedSegment: FriendsSegmentedControlEnum = FriendsSegmentedControlEnum.Following
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendsTableView.delegate = self
        friendsTableView.dataSource = self
        friendsTableView.rowHeight = UITableViewAutomaticDimension
        friendsTableView.estimatedRowHeight = 120.0
        
        //Temp Current Player
        currentPlayer = _PLAYERS[7]
        
        playersFollowers = self.currentPlayer.getFollowers()
        playersFollowing = self.currentPlayer.getFollowing()
        // Do any additional setup after loading the view.
        var tblView =  UIView(frame: CGRectZero)
        friendsTableView.tableFooterView = tblView
        friendsTableView.tableFooterView?.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onFriendsSegControlTap(sender: UISegmentedControl) {
        self.selectedSegment = FriendsSegmentedControlEnum(rawValue: self.friendsSegControl.selectedSegmentIndex)!
        NSLog("friendsSegControl index :\(selectedSegment)")
        friendsTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.selectedSegment {
            case .Following:
                return playersFollowing!.count
            case .Followers:
                return playersFollowers!.count
            default:
                return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = friendsTableView.dequeueReusableCellWithIdentifier("playersListTableViewCell") as PlayersListTableViewCell
        var player: PkkupPlayer!
        switch self.selectedSegment {
        case .Following:
            player = playersFollowing![indexPath.row]
        case .Followers:
            player = playersFollowers![indexPath.row]
        default:
            player = nil
            NSLog("ERROR: SwitchCase default value called in friendsTable View")
        }
        cell.player = player
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        var player: PkkupPlayer!
        switch self.selectedSegment {
        case .Following:
            player = playersFollowing![indexPath.row]
        case .Followers:
            player = playersFollowers![indexPath.row]
        default:
            player = nil
            NSLog("ERROR: SwitchCase default value called in friendsTable View")
        }
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        var playerDetailsViewController = storyboard.instantiateViewControllerWithIdentifier("PlayerDetailsViewController") as PlayerDetailsViewController
        playerDetailsViewController.view.layoutSubviews()
        playerDetailsViewController.player = player
        self.navigationController?.pushViewController(playerDetailsViewController, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
