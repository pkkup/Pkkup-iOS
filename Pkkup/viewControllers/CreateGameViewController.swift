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
    
    @IBOutlet weak var locationLabel: UILabel!
    
    var locations: [PkkupLocation] = _LOCATIONS
    var games: [PkkupGame] = _GAMES
    var sports: [PkkupSport] = _SPORTS
    var isPickerChanged: Bool! = false
    
    var sectionExpanded = [0: false, 1: false]
    var locationRowSelected = 0
    var sportRowSelected = 0
    
    var delegate:CreateGameViewControllerDelegate?
    
    var selectedLocation: String!
    var selectedSport: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createGameTableView.dataSource = self
        createGameTableView.delegate = self
        
        self.createGameTableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var headerView = UIView(frame: CGRect(x:0, y:0, width: 320, height: 40))
        headerView.backgroundColor = UIColor.whiteColor()
        var headerLabel = UILabel(frame: CGRect(x:0, y:0, width:320, height: 40))
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
            return UITableViewCell()
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        createGameTableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        var section = indexPath.section
        if (section == 0 || section == 1) {
            if (sectionExpanded[section] == true) {
                if (section == 1) {
                    locationRowSelected = indexPath.row
                    self.delegate?.locationSelected(locations[indexPath.row].name!, rowSelected: indexPath.row)
                } else {
                    sportRowSelected = indexPath.row
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
        return 2
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
    }

}
