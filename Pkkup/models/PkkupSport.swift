//
//  PkkupSport.swift
//  Pkkup
//
//  Copyright (c) 2014 Pkkup. All rights reserved.
//

import Foundation

var _sports: [PkkupSport]?
var PKKUP_SPORTS_KEY = "kPkkupSports"

var _pkkupSportCache = [Int:PkkupSport]()

class PkkupSport {
    var sportDictionary: NSDictionary?

    var id: Int?
    var name: String?
    // Maybe?
    var iconImageUrl: String?
    
    var isSportSelected :Bool?
    
    init(dictionary: NSDictionary) {
        self.sportDictionary = dictionary

        id = dictionary["id"] as? Int
        name = dictionary["name"] as? String
        
//        iconImageUrl = dictionary["img_url"] as? String
//        isSportSelected = dictionary["isSelected"] as? Bool
        _pkkupSportCache[id!] = self
    }

    class func sportsWithArray(array: [NSDictionary]) -> [PkkupSport] {
        var sports = [PkkupSport]()
        for dictionary in array {
            sports.append(PkkupSport(dictionary: dictionary))
        }
        return sports
    }

    class var sports: [PkkupSport]? {
        get {
            if _sports == nil {
                var data = HTKUtils.getDefaults(PKKUP_SPORTS_KEY) as? NSData
                if data != nil {
                    var sportsDictionaries = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as[NSDictionary]
                    _sports = PkkupSport.sportsWithArray(sportsDictionaries)
                }
            }
            return _sports
        }
        set (sports) {
            _sports = sports
            if _sports != nil {
                var sportsDictionaries: [NSDictionary] = sports!.map({
                    (sport: PkkupSport) -> NSDictionary in
                    sport.sportDictionary!
                })
                var data = NSJSONSerialization.dataWithJSONObject(sportsDictionaries, options: nil, error: nil)
                HTKUtils.setDefaults(PKKUP_SPORTS_KEY, withValue: data)
            } else {
                HTKUtils.setDefaults(PKKUP_SPORTS_KEY, withValue: nil)
            }
        }
    }

    class func getCached(id: Int) -> PkkupSport {
        return _pkkupSportCache[id]!
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

}
