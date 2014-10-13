//
//  GameDetailsViewController.swift
//  Pkkup
//
//  Copyright (c) 2014 Pkkup. All rights reserved.
//

import UIKit

class GameDetailsViewController: PkkupViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var placeLabel: UILabel!
    
    @IBOutlet weak var playersListTable: UITableView!
    
    var playerArray = ["Deepak", "Jonathan", "Chandra", "Tim", "Shen",
                       "John", "Jim", "Russel", "Matt", "Brandon"]
    
    var pkkupPlayer: PkkupPlayer!;
    
    // TODO: wire outlets from views here
    var game: PkkupGame! {
        didSet(game) {

        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        playersListTable.dataSource = self
        playersListTable.delegate = self
        timeLabel.text = "8:45am 12th Apr, 2014 (Tuesday)"
        placeLabel.text = "Cuesta Park, 233 Grant Road"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = playersListTable.dequeueReusableCellWithIdentifier("playersListTableViewCell") as PlayersListTableViewCell
            cell.playerLabel.text = playerArray[indexPath.row]
            return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Players Going:"
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        println("row selected..")
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        println("prepareForSegue to PlayerDetails")
        if (segue.identifier == "playerDetailSegue") {
            var playerDetailVC = segue.destinationViewController as PlayerDetailsViewController
            /*let indexPath = self.playersListTable.indexPathForSelectedRow()?.row
            pkkupPlayer.firstName = playerArray[indexPath!]
            playerDetailVC.player = pkkupPlayer*/
        }
    }


}
