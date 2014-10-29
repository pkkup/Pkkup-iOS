//
//  PkkupLocation.swift
//  Pkkup
//
//  Copyright (c) 2014 Pkkup. All rights reserved.
//

import Foundation
import CoreLocation

var _pkkupLocationCache = NSCache()

class PkkupLocation {
    var locationDictionary: NSDictionary

    // Location attributes
    var id: Int?
    var name: String?
    var address: String?
    var city: String?
    var state: String?
    var zipcode: String?
    var latitude: Double?
    var longitude: Double?

    // Relations
    var games: [PkkupGame]?
    var players: [PkkupPlayer]?

    init(dictionary: NSDictionary) {
        self.locationDictionary = dictionary
        
        id = dictionary["id"] as? Int
        name = dictionary["name"] as? String
        address = dictionary["address"] as? String
        city = dictionary["city"] as? String
        state = dictionary["state"] as? String
        zipcode = dictionary["zipcode"] as? String
        latitude = dictionary["latitude"] as? Double
        longitude = dictionary["longitude"] as? Double
        //var gamesDict = dictionary["games"] as? NSDictionary
        //var upcomingArray = gamesDict?["upcoming"] as? [NSDictionary]
        //var len = upcomingArray.count
        //println(upcomingArray!.count)
        //if(upcomingArray!.count == 16) {
        //    println(upcomingArray![0])
        //    println(upcomingArray![2])
        //}
        _pkkupLocationCache.setObject(self, forKey: id!)
    }

    class func locationsWithArray(array: [NSDictionary]) -> [PkkupLocation] {
        var locations = [PkkupLocation]()
        for dictionary in array {
            locations.append(PkkupLocation(dictionary: dictionary))
        }
        return locations
    }

    class func get(id: Int) -> PkkupLocation {
        var location = PkkupLocation.getCached(id)!
        return location
    }

    class func getCached(id: Int) -> PkkupLocation? {
        var location = _pkkupLocationCache.objectForKey(id) as? PkkupLocation
        return location
    }
    
    class func locationsWithIds(locationIds: [Int]) -> [PkkupLocation] {
        var locations = locationIds.map({
            (locationId: Int) -> PkkupLocation in
            PkkupLocation.get(locationId)
        })
        return locations
    }

    func getCityAndStateString() -> String {
        var value = "\(self.city!), \(self.state!)"
        return value
    }

    func getWeather() {
        // get from Forecast.io
        // temp, status (sunny, cloudy, etc)
    }

    func getGames() -> [PkkupGame]? {
        // get and store locally
        return self.games
    }

    func getCurrentDistanceInMeters() -> Double? {
        var currentLocation = HTKLocationUtils.sharedInstance.mostRecentLocation
        var distanceMeters: Double?
        if let currentLocation = currentLocation {
            var thisCLLocation = CLLocation(latitude: self.latitude!, longitude: self.longitude!)
            distanceMeters = currentLocation.distanceFromLocation(thisCLLocation)
        }
        return distanceMeters
    }

    func getCurrentDistanceInMiles() -> Double? {
        var distanceMeters = getCurrentDistanceInMeters()
        var distanceMiles: Double?
        if let distanceMeters = distanceMeters {
            let metersPerMile = 1609.344
            distanceMiles = distanceMeters / metersPerMile
        }
        return distanceMiles
    }

    func getMap() {
        // use MapKit
    }
    
}
