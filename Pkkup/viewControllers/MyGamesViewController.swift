//
//  MyGamesViewController.swift
//  Pkkup
//
//  Created by Deepak on 10/19/14.
//  Copyright (c) 2014 Pkkup. All rights reserved.
//

import UIKit
enum MyGamesSegmentedControlEnum: Int {
    case Upcoming  = 0
    case Saved     = 1
    case Locations = 2
}

class MyGamesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var currentPlayer: PkkupPlayer!
    var gamesConfirmed: [PkkupGame]!
    var gamesMaybe: [PkkupGame]!
    var gamesRecent: [PkkupGame]!
    var myLocations: [PkkupLocation]!
    @IBOutlet weak var myGamesSegControl: UISegmentedControl!
    var selectedSegment: MyGamesSegmentedControlEnum = MyGamesSegmentedControlEnum.Upcoming
    
    @IBOutlet weak var gamesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        gamesTableView.dataSource = self
        gamesTableView.delegate = self
        gamesTableView.rowHeight = UITableViewAutomaticDimension
        gamesTableView.estimatedRowHeight = 80.0
        myGamesSegControl.tintColor = _THEME_COLOR
        self.navigationController?.navigationBar.barTintColor = _THEME_COLOR
        // Do any additional setup after loading the view.
        
        //Temp Current Player
        self.currentPlayer = _PLAYERS[7]
        //println(self.currentPlayer.playerDictionary)
        gamesConfirmed = self.currentPlayer.getGamesConfirmed()
        gamesMaybe     = self.currentPlayer.getGamesMaybe()
        //println(gamesMaybe)
        myLocations    = self.currentPlayer.getLocations()
        //println(myLocations)
        //gamesRecent    = self.currentPlayer.getGamesRecent()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onMyGamesSegControlTap(sender: AnyObject) {
        self.selectedSegment = MyGamesSegmentedControlEnum(rawValue: self.myGamesSegControl.selectedSegmentIndex)!
        NSLog("myGamesSegControl index :\(selectedSegment)")
        gamesTableView.reloadData()
        
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
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//        var game = self.gamesConfirmed[indexPath.row]
//        println(game)
//        println(game.location?.city)
//        var storyboard = UIStoryboard(name: "Main", bundle: nil)
//        var gameDetailsViewController = storyboard.instantiateViewControllerWithIdentifier("GameDetailsViewController") as GameDetailsViewController
//        gameDetailsViewController.view.layoutSubviews()
//        gameDetailsViewController.game = game
//        self.navigationController?.pushViewController(gameDetailsViewController, animated: true)
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "gameDetailSegue1") {
            let gameDetailsViewController = segue.destinationViewController as GameDetailsViewController
            var indexPath = self.gamesTableView.indexPathForSelectedRow()?.row
            switch self.selectedSegment {
                case .Upcoming:
                    var game = self.gamesConfirmed[indexPath!]
                    gameDetailsViewController.game = game
                case .Saved:
                    var game = self.gamesMaybe[indexPath!]
                    gameDetailsViewController.game = game
                default:
                    println("default case error")
            }
            
        } else if (segue.identifier == "locationSegue") {
            let locationDetailsViewController = segue.destinationViewController as LocationDetailsViewController
            var indexPath = self.gamesTableView.indexPathForSelectedRow()?.row
            var location = self.myLocations[indexPath!]
            locationDetailsViewController.location = location
        }
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
