//
//  LocationDetailsViewController.swift
//  Pkkup
//
//  Copyright (c) 2014 Pkkup. All rights reserved.
//

import UIKit

class LocationDetailsViewController: PkkupViewController, UITableViewDataSource, UITableViewDelegate {

    // TODO: wire outlets from views here
    @IBOutlet weak var gameHistoryTableView: UITableView!

    var location: PkkupLocation! {
        willSet(newLocation) {
        }

        didSet(oldLocation) {
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        gameHistoryTableView.dataSource = self
        gameHistoryTableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = gameHistoryTableView.dequeueReusableCellWithIdentifier("GameHistoryCell") as GameHistoryCell
        cell.sportNameLabel.text = "Soccer"
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
