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
    case Recent = 2
}

class LocationDetailsViewController: PkkupViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var mapDetailsView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationSegmentControl: UISegmentedControl!
    @IBOutlet weak var gameHistoryTableView: UITableView!
    
    @IBOutlet weak var locationLabel: UILabel!
    var selectedSegmentControl: Int!
    
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
        }

        didSet(oldLocation) {
            //println("didSet called")

            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        gameHistoryTableView.dataSource = self
        gameHistoryTableView.delegate = self
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
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = gameHistoryTableView.dequeueReusableCellWithIdentifier("GameHistoryCell") as GameHistoryCell
        cell.sportNameLabel.text = sports[indexPath.row]
        return cell
    }
    
    @IBAction func onLocationSegmentCtrlChange(sender: AnyObject) {
        println("Segment control changed: \(locationSegmentControl.selectedSegmentIndex)")
        self.selectedSegmentControl = locationSegmentControl.selectedSegmentIndex
    }


}
