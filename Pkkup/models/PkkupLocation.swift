//
//  PkkupLocation.swift
//  Pkkup
//
//  Copyright (c) 2014 Pkkup. All rights reserved.
//

import Foundation

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

    func getMap() {
        // use MapKit
    }
    
}
