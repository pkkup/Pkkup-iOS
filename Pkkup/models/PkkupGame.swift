//
//  PkkupGame.swift
//  Pkkup
//
//  Copyright (c) 2014 Pkkup. All rights reserved.
//

import Foundation

var _pkkupGameCache = NSCache()

class PkkupGame {
    var gameDictionary: NSDictionary?

    var id: Int?
    var sportId: Int?
    var sport: PkkupSport?
    var startTime: NSDate?
    var duration: NSTimeInterval?
    var location: PkkupLocation?
    var locationId: Int?
    var playersConfirmedIds: [Int]?
    var playersConfirmed: [PkkupPlayer]?
    var playersDeclinedIds: [Int]?
    var playersDeclined: [PkkupPlayer]?
    var playersMaybeIds: [Int]?
    var playersMaybe: [PkkupPlayer]?
    var notes: String?
    
    init() {
        
    }
    // Probably not...
//    var groups: [Group]?
    init(dictionary: NSDictionary) {
        self.gameDictionary = dictionary
        
        id = dictionary["id"] as? Int
        sportId = dictionary["sport"] as? Int
        sport = PkkupSport.getCached(sportId!)
        locationId = dictionary["location"] as? Int
        var startTimeTimestamp = dictionary["start_time"] as? Int
        startTime = NSDate(timeIntervalSince1970: NSTimeInterval(startTimeTimestamp!))
        playersConfirmedIds = dictionary["confirmed"] as? [Int]
        playersDeclinedIds = dictionary["declined"] as? [Int]
        playersMaybeIds = dictionary["maybe"] as? [Int]
        _pkkupGameCache.setObject(self, forKey: id!)
    }

    class func gamesWithArray(array: [NSDictionary]) -> [PkkupGame] {
        var games = [PkkupGame]()
        for dictionary in array {
            games.append(PkkupGame(dictionary: dictionary))
        }
        return games
    }

    class func get(id: Int) -> PkkupGame {
        var game = PkkupGame.getCached(id)!
        return game
    }

    class func getCached(id: Int) -> PkkupGame? {
        var game = _pkkupGameCache.objectForKey(id) as? PkkupGame
        return game
    }
    class func gamesWithIds(gameIds: [Int]) -> [PkkupGame] {
        var games = gameIds.map({
            (gameId: Int) -> PkkupGame in
            PkkupGame.get(gameId)
        })
        return games
    }

    func getLocation() -> PkkupLocation {
        if location != nil {
            return location!
        } else {
            return PkkupLocation.get(locationId!)
        }
    }

    func getFormattedStartTime() -> String {
        let dateFormatter = NSDateFormatter()
        //dateFormatter.dateFormat = "yyyy-MM-dd 'at' h:mm a"
        dateFormatter.dateFormat = "EEE, MMM d, yyyy 'at' h:mm a"
        var formatted = dateFormatter.stringFromDate(self.startTime!)
        return formatted
    }

    func getPlayersConfirmed() -> [PkkupPlayer] {
        var players = self.playersConfirmedIds!.map {
            (playerId: Int) -> PkkupPlayer in
            PkkupPlayer.get(playerId)
        }
        return players
    }
    
    
}
