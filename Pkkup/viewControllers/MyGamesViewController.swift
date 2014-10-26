//
//  MyGamesViewController.swift
//  Pkkup
//
//  Created by Deepak on 10/19/14.
//  Copyright (c) 2014 Pkkup. All rights reserved.
//

import UIKit

class MyGamesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var currentPlayer: PkkupPlayer!
    var gamesConfirmed: [PkkupGame]!
    var gamesMaybe: [PkkupGame]!
    var gamesRecent: [PkkupGame]!
    @IBOutlet weak var gamesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        gamesTableView.dataSource = self
        gamesTableView.delegate = self
        gamesTableView.rowHeight = UITableViewAutomaticDimension
        gamesTableView.estimatedRowHeight = 80.0
        // Do any additional setup after loading the view.
        
        //Temp Current Player
        self.currentPlayer = _PLAYERS[7]
        //println(self.currentPlayer.playerDictionary)
        gamesConfirmed = self.currentPlayer.getGamesConfirmed()
        //gamesMaybe     = self.currentPlayer.getGamesMaybe()
        //gamesRecent    = self.currentPlayer.getGamesRecent()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.gamesConfirmed.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = gamesTableView.dequeueReusableCellWithIdentifier("GamesCell") as GamesCell
        var game = self.gamesConfirmed[indexPath.row]
        cell.game = game
        return cell
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
            var game = self.gamesConfirmed[indexPath!]
            gameDetailsViewController.game = game
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
