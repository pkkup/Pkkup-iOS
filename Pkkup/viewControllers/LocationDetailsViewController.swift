//
//  LocationDetailsViewController.swift
//  Pkkup
//
//  Copyright (c) 2014 Pkkup. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

enum LocationSegmentedControlEnum: Int {
    case Today  = 0
    case Upcoming = 1
    case Past = 2
}

class LocationDetailsViewController: PkkupViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var mapDetailsView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationSegmentControl: UISegmentedControl!
    @IBOutlet weak var gameHistoryTableView: UITableView!
    
    @IBOutlet weak var locationLabel: UILabel!
    var selectedSegment: LocationSegmentedControlEnum = LocationSegmentedControlEnum.Today
    var upcomingGames: [PkkupGame]!
    var todayGames: [PkkupGame]!
    var pastGames: [PkkupGame]!
    
    var sports: [String] = ["Basketball", "Soccer", "Football", "Baseball", "Cricket"]
    
    var coordinate = CLLocationCoordinate2DMake(37.33233141, -122.0312186)
    //var coordinate = CLLocationCoordinate2D
    var location: PkkupLocation! {
        willSet(newLocation) {
            //coordinate = CLLocationCoordinate2DMake(37.33233141, -122.0312186)
            coordinate = CLLocationCoordinate2DMake(newLocation.latitude!, newLocation.longitude!)
            //println("willSet called, \(coordinate.latitude), \(coordinate.longitude)")
            //CLLocationManager requestWhenInUseAuthorization
            var region = MKCoordinateRegionMakeWithDistance(coordinate, 1000,1000)
            var point = MKPointAnnotation()
            point.coordinate = coordinate
            point.title = newLocation.name
            point.subtitle = newLocation.address
            self.mapView.setRegion(region, animated: true)
            self.mapView.addAnnotation(point)
            self.locationLabel.text = "\(newLocation.name!), \(newLocation.city!), \(newLocation.state!)"
            self.upcomingGames = newLocation.upcomingGames
            self.todayGames = newLocation.todayGames
            self.pastGames = newLocation.pastGames
        }

        didSet(oldLocation) {
            //println("didSet called")

            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        gameHistoryTableView.dataSource = self
        gameHistoryTableView.delegate = self
        gameHistoryTableView.rowHeight = UITableViewAutomaticDimension
        self.mapDetailsView.backgroundColor = _THEME_COLOR
        self.mapView.showsUserLocation = true
        self.mapView.showsPointsOfInterest = true
        self.locationSegmentControl.tintColor = _THEME_COLOR
        mapView.showsUserLocation = true
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.selectedSegment {
        case .Today:
            return self.todayGames.count
        case .Upcoming:
            return self.upcomingGames.count
        case .Past:
            return self.pastGames.count
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = gameHistoryTableView.dequeueReusableCellWithIdentifier("GameHistoryCell") as GameHistoryCell
        
        switch self.selectedSegment {
        case .Today:
            cell.game = self.todayGames[indexPath.row]
        case .Upcoming:
            cell.game = self.upcomingGames[indexPath.row]
        case .Past:
            cell.game = self.pastGames[indexPath.row]
        default:
            println("default case")
        }
        return cell
    }
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        var game: PkkupGame!
//        
//        switch self.selectedSegment {
//        case .Today:
//            game = self.todayGames[indexPath.row]
//        case .Upcoming:
//            game = self.upcomingGames[indexPath.row]
//        default:
//            println("default case error")
//            return
//        }
//        
//        var storyboard = UIStoryboard(name: "Main", bundle: nil)
//        var gameDetailsViewController = storyboard.instantiateViewControllerWithIdentifier("GameDetailsViewController") as GameDetailsViewController
//        gameDetailsViewController.view.layoutSubviews()
//        gameDetailsViewController.game = game
//        self.navigationController?.pushViewController(gameDetailsViewController, animated: true)
//    }
    
    
    @IBAction func onLocationSegmentCtrlChange(sender: AnyObject) {
        println("Segment control changed: \(locationSegmentControl.selectedSegmentIndex)")
        self.selectedSegment = LocationSegmentedControlEnum(rawValue: self.locationSegmentControl.selectedSegmentIndex)!
        gameHistoryTableView.reloadData()
    }


}
