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
    var pkkupGame : PkkupGame!
    var pkkupSports : [PkkupSport]?
    @IBOutlet var sportsCollectionView: UICollectionView!
    @IBOutlet weak private var resultsTableView: UITableView!

    let SPORT_CHOICES_DEFAULT_HEIGHT = CGFloat(44)
    
    var sportDictionary: NSDictionary = ["name" : "Basketball", "img_url": "" , "isSelected": true]

    
    /*
    var sportsDictArray: [NSDictionary]? = [[ "name" : "Basketball", "img_url": "" , "isSelected":true],
                                         ["name" : "Volleyball", "img_url": "" , "isSelected": false],
                                        [ "name" : "Tennis", "img_url": "" , "isSelected": false]]
    
    

    [ "name" : "Tennis", "img_url": "" , "isSelected": false],
    [ "name" : "Cricket", "img_url": "" , "isSelected": false],
    [ "name" : "Ultimate Fresbee", "img_url": "" , "isSelected": false],
    [ "name" : "Soccer", "img_url": "" , "isSelected": false],
    [ "name" : "Football", "img_url": "" , "isSelected": false],
    [ "name" : "Baseball", "img_url": "" , "isSelected": false],
    [ "name" : "Softball", "img_url": "" , "isSelected": false]] */

    //println("sportsArray")
    //

    var sportsArray = [ "Basketball", "Volleyball", "Tennis", "Cricket", "Soccer", "Football"]
    var sectionsArray = [ "San Jose, CA", "Santa Clara, CA", "Sunnyvale, CA", "Mountain View, CA",
                          "Palo Alto, CA", "Menlo Park, CA", "Redwood City, CA", "Milpitas, CA", "Fremont, CA"]
    var gameTimeString = "8.00 pm, 8th Apr, 2014"
    var gameLocation = "Cuesta Park"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sportsCollectionView.dataSource = self
        sportsCollectionView.delegate   = self
        //var pkkupSports = PkkupSport.pkkupSportsWithArray(sportsDictArray! as [NSDictionary])
        println(pkkupSports)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionsArray.count
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionsArray[section]
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = resultsTableView.dequeueReusableCellWithIdentifier("ResultViewCell") as ResultTableViewCell
        cell.pkkupGame = pkkupGame
        return cell
    }
    
    //MARK: - Delegate
    func sportWasSelected(sportCell: SportsCollectionViewCell, selectedSport: String) -> Void {
        NSLog(selectedSport)
    }
    //MARK: - CollectionView
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportsArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("sportsCollectionViewCell", forIndexPath: indexPath) as SportsCollectionViewCell
            cell.sportButton.setTitle(sportsArray[indexPath.row], forState: UIControlState.Normal)
            //var sport = self.pkkupSports?[indexPath.row]
            cell.delegate = self
        return cell
        
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
            if (segue.identifier == "gameDetailSegue") {
                let gameDetVC = segue.destinationViewController as GameDetailsViewController
                //let indexPath = self.resultsTableView.indexPathForSelectedRow()?.row
                gameDetVC.game = pkkupGame

            }
    }


}
