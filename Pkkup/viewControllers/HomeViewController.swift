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
    var gamesByCity = [String:[PkkupGame]]()
    var selectedSport:String?

    var sectionHeadings = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sportsCollectionView.dataSource = self
        sportsCollectionView.delegate   = self
        resultsTableView.rowHeight = UITableViewAutomaticDimension
        resultsTableView.estimatedRowHeight = 120.0
        var tblView =  UIView(frame: CGRectZero)
        resultsTableView.tableFooterView = tblView
        resultsTableView.tableFooterView?.hidden = true
        //resultsTableView.backgroundColor = UIColor.blackColor()
        self.tabBarController?.tabBar.tintColor = UIColor.orangeColor()

        self.selectedSport = "Basketball"
        PkkupSport.selectSportWithName("Basketball")
        reloadGames()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func reloadGames() {
        var games = _GAMES.filter({
            (game: PkkupGame) -> Bool in
            game.sport!.name! == self.selectedSport
        })

        var citiesSeen = [String:Bool]()
        var newSectionHeadings = [String]()
        gamesByCity = [String:[PkkupGame]]()
        
        for game in games {
            var location = game.getLocation()
            var city = location.getCityAndStateString()

            if citiesSeen[city] == nil {
                citiesSeen[city] = true
                newSectionHeadings.append(city)
                gamesByCity[city] = [PkkupGame]()
            }
            var gamesInCity = gamesByCity[city]!
            gamesInCity.append(game)
            gamesByCity[city] = gamesInCity
        }
        self.sectionHeadings = newSectionHeadings
        self.resultsTableView.reloadData()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var cityAndState = sectionHeadings[section]
        var gamesInCity = gamesByCity[cityAndState]!
        var numRows = gamesInCity.count
        return numRows
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.sectionHeadings.count
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionHeadings[section]
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = resultsTableView.dequeueReusableCellWithIdentifier("ResultViewCell") as ResultTableViewCell
        var section = indexPath.section
        var cityAndState = sectionHeadings[section]
        var gamesInCity = gamesByCity[cityAndState]!
        var game = gamesInCity[indexPath.row]
        cell.game = game
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        resultsTableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    //MARK: - Delegate
    func sportWasSelected(sportCell: SportsCollectionViewCell, sportName: String) -> Void {
        self.selectedSport = sportName
        PkkupSport.selectSportWithName(sportName)

        self.sportsCollectionView?.reloadData()
        self.reloadGames()
    }

    //MARK: - CollectionView
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PkkupSport.sports!.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("sportsCollectionViewCell", forIndexPath: indexPath) as SportsCollectionViewCell
        var sport = PkkupSport.sports![indexPath.row]
        cell.sport = sport
        cell.delegate = self
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "gameDetailSegue") {
            let gameDetailsViewController = segue.destinationViewController as GameDetailsViewController
            //let indexPath = self.resultsTableView.indexPathForSelectedRow()?.row
            var game = _GAMES[0]
            gameDetailsViewController.game = game
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
