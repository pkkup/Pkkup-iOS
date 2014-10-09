//
//  PkkupPlayer.swift
//  Pkkup
//
//  Copyright (c) 2014 Pkkup. All rights reserved.
//

import Foundation

class PkkupPlayer {
    // Player Attributes
    var firstName: String?
    var lastName: String?
    var screenName: String?
    var email: String?
    var lat: Double?
    var long: Double?
    var bio: String?

    // Relations
    var sports: [PkkupSport]?
    var followers: [PkkupPlayer]?
    var following: [PkkupPlayer]?
    var gamesConfirmed: [PkkupGame]?
    var gamesMaybe: [PkkupGame]?
    var locations: [PkkupLocation]?

    // Maybe implement if we have time...
    var groups: [PkkupGroup]?
    
    func getGravatarImageUrl() {
        
    }
}
