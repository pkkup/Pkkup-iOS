//
//  MyGamesViewController.swift
//  Pkkup
//
//  Created by Deepak on 10/19/14.
//  Copyright (c) 2014 Pkkup. All rights reserved.
//

import UIKit

class MyGamesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var gamesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        gamesTableView.dataSource = self
        gamesTableView.delegate = self
        gamesTableView.rowHeight = UITableViewAutomaticDimension
        gamesTableView.estimatedRowHeight = 80.0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _GAMES.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = gamesTableView.dequeueReusableCellWithIdentifier("GamesCell") as GamesCell
        var game = _GAMES[indexPath.row]
        cell.game = game
        return cell
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
