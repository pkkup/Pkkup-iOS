//
//  HomeViewController.swift
//  Pkkup
//
//  Created by Jonathan Tsai on 10/4/14.
//  Copyright (c) 2014 Pkkup. All rights reserved.
//

import UIKit

class HomeViewController: PkkupViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, SportsCellDelegate {


    @IBOutlet weak var sportsContainerView: UIView!
    @IBOutlet var sportsCollectionView: UICollectionView!
    @IBOutlet weak private var resultsTableView: UITableView!

    let SPORT_CHOICES_DEFAULT_HEIGHT = CGFloat(44)
    
    var sectionsArray = [ "San Jose, CA", "Santa Clara, CA", "Sunnyvale, CA", "Mountain View, CA",
                          "Palo Alto, CA", "Menlo Park, CA", "Redwood City, CA", "Milpitas, CA", "Fremont, CA"]
    var gameTimeString = "8.00 pm, 8th Apr, 2014"
    var gameLocation = "Cuesta Park"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sportsCollectionView.dataSource = self
        sportsCollectionView.delegate   = self
        resultsTableView.rowHeight = UITableViewAutomaticDimension
        resultsTableView.estimatedRowHeight = 120.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _GAMES.count * 5
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionsArray.count
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionsArray[section]
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = resultsTableView.dequeueReusableCellWithIdentifier("ResultViewCell") as ResultTableViewCell
        var game = _GAMES[indexPath.row % _GAMES.count]
        cell.game = game
        return cell
    }
    
    //MARK: - Delegate
    func sportWasSelected(sportCell: SportsCollectionViewCell, selectedSport: String) -> Void {
        NSLog(selectedSport)
        for sport in PkkupSport.sports! {
            if(sport.name? == selectedSport) {
                sport.isSportSelected = true
            } else {
                sport.isSportSelected = false
            }
        }
        self.sportsCollectionView?.reloadData()
    }
    //MARK: - CollectionView
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PkkupSport.sports!.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("sportsCollectionViewCell", forIndexPath: indexPath) as SportsCollectionViewCell
        var sport = PkkupSport.sports![indexPath.row]
        cell.sportButton.setTitle(sport.name!, forState: UIControlState.Normal)
        if(sport.isSportSelected == true ) {
            cell.buttonSelectedView.backgroundColor = UIColor.orangeColor()
        } else {
            cell.buttonSelectedView.backgroundColor = UIColor.clearColor()
        }
        cell.delegate = self
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "gameDetailSegue") {
            let gameDetVC = segue.destinationViewController as GameDetailsViewController
            //let indexPath = self.resultsTableView.indexPathForSelectedRow()?.row
            var game = _GAMES[0]
            gameDetVC.game = game
        }
    }

    @IBAction func onCreateGame(sender: AnyObject) {
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        var createGameViewController = storyboard.instantiateViewControllerWithIdentifier("CreateGameViewController") as CreateGameViewController
        createGameViewController.view.layoutSubviews()
        //createGameViewController.player = player
        self.navigationController?.pushViewController(createGameViewController, animated: true)
    }
}
