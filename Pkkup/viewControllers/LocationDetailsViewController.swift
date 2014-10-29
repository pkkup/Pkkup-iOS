//
//  LocationDetailsViewController.swift
//  Pkkup
//
//  Copyright (c) 2014 Pkkup. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LocationDetailsViewController: PkkupViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationSegmentControl: UISegmentedControl!
    @IBOutlet weak var gameHistoryTableView: UITableView!
    
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
        }

        didSet(oldLocation) {
            //println("didSet called")

            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        gameHistoryTableView.dataSource = self
        gameHistoryTableView.delegate = self
        self.mapView.showsUserLocation = true
        self.mapView.showsPointsOfInterest = true
        
        mapView.showsUserLocation = true
        // Do any additional setup after loading the view, typically from a nib.
//        NSNotificationCenter.defaultCenter().addObserverForName(htkDidUpdateLocationNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (notification: NSNotification!) -> Void in
//            var userInfo = notification.userInfo!
//            var location = userInfo["location"] as CLLocation
//
//            //            MKCoordinateReg
////            var region = MKCoordinateRegionMakeWithDistance(location.coordinate, 1000, 1000)
////            //var region = MKCoordinateRegionMakeWithDistance(cordinate, 1000, 1000)
////            self.mapView.setRegion(region, animated: true)
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sports.count
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
