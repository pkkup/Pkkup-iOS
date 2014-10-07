//
//  Player.swift
//  Pkkup
//
//  Copyright (c) 2014 Pkkup. All rights reserved.
//

import Foundation

class Player {
    // Player Attributes
    var firstName: String?
    var lastName: String?
    var screenName: String?
    var email: String?
    var lat: Double?
    var long: Double?
    var bio: String?

    // Relations
    var sports: [Sport]?
    var followers: [Player]?
    var following: [Player]?
    var gamesConfirmed: [Game]?
    var gamesMaybe: [Game]?
    var locations: [Location]?

    // Maybe
    var groups: [Group]?
    
    func getGravatarImageUrl() {
        
    }
}
