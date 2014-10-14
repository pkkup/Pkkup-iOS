//
//  PkkupPlayer.swift
//  Pkkup
//
//  Copyright (c) 2014 Pkkup. All rights reserved.
//

import Foundation

var _currentPkkupPlayer: PkkupPlayer?
let PKKUP_CURRENT_USER_KEY = "kPkkupCurrentUserKey"
let PKKUP_USER_DID_LOGIN_NOTIFICATION = "pkkupUserDidLoginNotification"
let PKKUP_USER_DID_LOGOUT_NOTIFICATION = "pkkupUserDidLogoutNotification"

var _pkkupPlayerCache = [Int:PkkupPlayer]()

class PkkupPlayer {
    var playerDictionary: NSDictionary

    // Player Attributes
    var id: Int?
    var name: String?
    var username: String?
    var email: String?
    var gravatarHash: String?
    var latitude: Double?
    var longitude: Double?
    var biography: String?

    // Relations
    var sports: [PkkupSport]?
    var followers: [PkkupPlayer]?
    var following: [PkkupPlayer]?
    var gamesConfirmed: [PkkupGame]?
    var gamesMaybe: [PkkupGame]?
    var locations: [PkkupLocation]?

    // Maybe implement if we have time...
    var groups: [PkkupGroup]?

    init(dictionary: NSDictionary) {
        self.playerDictionary = dictionary
        id = dictionary["id"] as? Int
        username = dictionary["username"] as? String
        name = dictionary["name"] as? String
        gravatarHash = dictionary["gravatar_hash"] as? String
        biography = dictionary["biography"] as? String

        _pkkupPlayerCache[id!] = self
    }

    class func playersWithArray(array: [NSDictionary]) -> [PkkupPlayer] {
        var players = [PkkupPlayer]()
        for dictionary in array {
            players.append(PkkupPlayer(dictionary: dictionary))
        }
        return players
    }

    class func getCached(id: Int) -> PkkupPlayer {
        var player = _pkkupPlayerCache[id]!
        return player
    }

    class var currentPlayer: PkkupPlayer? {
        get {
            if _currentPkkupPlayer == nil {
                var data = HTKUtils.getDefaults(PKKUP_CURRENT_USER_KEY) as? NSData
                if data != nil {
                    var userDictionary = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as NSDictionary
                    _currentPkkupPlayer = PkkupPlayer(dictionary: userDictionary)
                }
            }
            return _currentPkkupPlayer
        }
        
        set (player) {
            _currentPkkupPlayer = player
            if _currentPkkupPlayer != nil {
                var data = NSJSONSerialization.dataWithJSONObject(player!.playerDictionary, options: nil, error: nil)
                HTKUtils.setDefaults(PKKUP_CURRENT_USER_KEY, withValue: data)
            } else {
                HTKUtils.setDefaults(PKKUP_CURRENT_USER_KEY, withValue: nil)
            }
        }
    }

    func logout() {
        PkkupPlayer.currentPlayer = nil
        PkkupClient.sharedInstance.logout()
        NSNotificationCenter.defaultCenter().postNotificationName(PKKUP_USER_DID_LOGOUT_NOTIFICATION, object: nil)
    }

    func getGravatarImageUrl() -> String {
        var url = "http://www.gravatar.com/avatar/\(self.gravatarHash!)"
        return url
    }
}
