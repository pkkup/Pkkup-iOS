//
//  PkkupSport.swift
//  Pkkup
//
//  Copyright (c) 2014 Pkkup. All rights reserved.
//

import Foundation

class PkkupSport {
    var name: String?
    // Maybe?
    var iconImageUrl: String?
    
    var isSportSelected :Bool?
    
    
    init(dictionary: NSDictionary) {
        name = dictionary["name"] as? String
        iconImageUrl = dictionary["img_url"] as? String
        isSportSelected = dictionary["isSelected"] as? Bool
    }

    func getPlayers() -> [PkkupPlayer] {
        return []
    }

    func getLocations() -> [PkkupLocation] {
        return []
    }

    func getGames() -> [PkkupGame] {
        return []
    }
    
    class func pkkupSportsWithArray(array: [NSDictionary]) -> [PkkupSport] {
        var sports = [PkkupSport]()
        for dictionary in array {
            sports.append(PkkupSport(dictionary: dictionary))
        }
        return sports
    }
}
