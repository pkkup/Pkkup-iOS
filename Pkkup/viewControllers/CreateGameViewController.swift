//
//  CreateGameViewController.swift
//  Pkkup
//
//  Created by Deepak on 10/19/14.
//  Copyright (c) 2014 Pkkup. All rights reserved.
//

import UIKit

protocol CreateGameViewControllerDelegate
{
    func locationSelected(location: String, rowSelected: Int)
    func sportSelected(sport: String, rowSelected: Int)
}

class CreateGameViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CreateGameViewControllerDelegate {
    @IBOutlet weak var createGameButton: UIButton!

    @IBOutlet var createGameTableView: UITableView!
    @IBOutlet weak var gameDatePicker: UIDatePicker!

    
    var locations: [PkkupLocation] = _LOCATIONS
    var games: [PkkupGame] = _GAMES
    var sports: [PkkupSport] = _SPORTS
    var isPickerChanged: Bool! = false
    
    var sectionExpanded = [0: false, 1: false]
    var locationRowSelected = 0
    var sportRowSelected = 0
    var gameDate: String!
    
    var delegate:CreateGameViewControllerDelegate?
    
    var selectedLocation: String!
    var selectedSport: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = _THEME_COLOR
        
        createGameTableView.dataSource = self
        createGameTableView.delegate = self
        
        self.createGameTableView.reloadData()
        
        gameDatePicker.addTarget(self, action: Selector("datePickerChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var headerView = UIView(frame: CGRect(x:0, y:0, width: 320, height: 30))
        headerView.backgroundColor = UIColor.whiteColor()
        var headerLabel = UILabel(frame: CGRect(x:0, y:0, width:320, height: 30))
        if (section == 0) {
            headerLabel.text = "Location"
        }
        if (section == 1) {
            headerLabel.text = "Sport"
        }
        
        headerView.addSubview(headerLabel)
        return headerView

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(section == 0) {
            if (sectionExpanded[section] == true) {
                return locations.count
            } else {
                return 1
            }
            
        }
        
        if(section == 1) {
            if (sectionExpanded[section] == true) {
                return sports.count
            } else {
                return 1
            }
        }
         return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var section = indexPath.section
        if(section == 0 || section == 1) {
            var cell = tableView.dequeueReusableCellWithIdentifier("LocationSportCell") as LocationSportCell
            cell.section = indexPath.section
            if (!sectionExpanded[section]!) {
                if (section == 0) {
                    cell.row = locationRowSelected
                } else if section == 1 {
                    cell.row = sportRowSelected
                }
            } else {
                cell.row = indexPath.row
            }
            cell.sportSelected = self.sportRowSelected
            cell.locationSelected = self.locationRowSelected
            cell.sectionExpanded = sectionExpanded[section]!
            
            cell.createGameDelegate = delegate
            return cell

        } else {
            //var cell = tableView.dequeueReusableCellWithIdentifier("CreateGameCell") as CreateGameCell
            return UITableViewCell()
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        createGameTableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        var section = indexPath.section
        if (section == 0 || section == 1) {
            if (sectionExpanded[section] == true) {
                if (section == 0) {
                    locationRowSelected = indexPath.row
                    println("locationRowSelected = \(locationRowSelected)")
                    self.delegate?.locationSelected(locations[indexPath.row].name!, rowSelected: indexPath.row)
                } else {
                    sportRowSelected = indexPath.row
                    println("sportRowSelected = \(sportRowSelected)")
                    self.delegate?.sportSelected(sports[indexPath.row].name!, rowSelected: indexPath.row)
                }
                sectionExpanded[section] = false
            } else {
                sectionExpanded[section] = true
            }
        }
        
        tableView.reloadSections(NSIndexSet(index: indexPath.section), withRowAnimation: UITableViewRowAnimation.Fade)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func locationSelected(location: String, rowSelected: Int) {
        self.selectedLocation = location
        self.locationRowSelected = rowSelected
    }
    
    func sportSelected(sport: String, rowSelected: Int) {
        self.selectedSport = sport
        self.sportRowSelected = rowSelected
    }
    
    @IBAction func onCreate(sender: AnyObject) {
        //var sportId: Int = (PkkupSport)self.sportRowSelected
        var sportName: String = PkkupSport.get(self.sportRowSelected).name!
        var newGame: PkkupGame = PkkupGame()
        newGame.location?.id = self.locationRowSelected
        newGame.sport?.id = self.sportRowSelected
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        newGame.startTime = dateFormatter.dateFromString(self.gameDate)
    }
    
    func datePickerChanged(datePicker:UIDatePicker) {
        println("Date changed ####")
        var dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        var strDate = dateFormatter.stringFromDate(datePicker.date)
        self.gameDate = strDate
        println("Game strDate = \(strDate)")
    }

    @IBAction func onViewTap(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

}
