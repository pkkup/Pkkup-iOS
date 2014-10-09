//
//  HomeViewController.swift
//  Pkkup
//
//  Created by Jonathan Tsai on 10/4/14.
//  Copyright (c) 2014 Pkkup. All rights reserved.
//

import UIKit

class HomeViewController: PkkupViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak private var searchBar: UISearchBar!
    @IBOutlet weak private var sportsContainerView: UIView!
    @IBOutlet weak private var sportsContainerHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak private var resultsTableView: UITableView!

    let SPORT_CHOICES_DEFAULT_HEIGHT = CGFloat(44)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        hideSportChoices()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = resultsTableView.dequeueReusableCellWithIdentifier("ResultViewCell") as ResultTableViewCell
        return cell
    }

    func hideSportChoices() {
        sportsContainerHeightConstraint.constant = 0
        
    }

    func showSportChoices() {
        sportsContainerHeightConstraint.constant = SPORT_CHOICES_DEFAULT_HEIGHT
    }

    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        showSportChoices()
        return true
    }

    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        hideSportChoices()
        return true
    }

    @IBAction func onTap(sender: UITapGestureRecognizer) {
        view.endEditing(true)
        hideSportChoices()
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
