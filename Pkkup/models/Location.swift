//
//  Location.swift
//  Pkkup
//
//  Copyright (c) 2014 Pkkup. All rights reserved.
//

import Foundation

class Location {
    // Location attributes
    var name: String?
    var streetAddress: String?
    var city: String?
    var state: String?
    var lat: Double?
    var long: Double?

    // Relations
    var games: [Game]?
    var players: [Player]?

    func getWeather() {
        // get from Forecast.io
        // temp, status (sunny, cloudy, etc)
    }

    func getGames() -> [Game]? {
        // get and store locally
        return self.games
    }

    func getMap() {
        // use MapKit
    }
    
}
