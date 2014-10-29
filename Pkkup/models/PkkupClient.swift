//
//  PkkupClient.swift
//  Pkkup
//
//  Copyright (c) 2014 Pkkup. All rights reserved.
//

import Foundation

let PKKUP_API_BASE_URL = "http://pkkup.com/api"

// Temporary globals
var _GAMES = [PkkupGame]()
var _LOCATIONS = [PkkupLocation]()
var _PLAYERS = [PkkupPlayer]()
var _GROUPS = [PkkupGroup]()
var _CURRENT_PLAYER : PkkupPlayer!
var _SPORTS = [PkkupSport]()

// A class for handling all API calls and networking
class PkkupClient: BDBOAuth1RequestOperationManager {
    var cache = [String:AnyObject]()

    var loginCompletion: ((user: PkkupPlayer?, error: NSError?) -> ())?

    var accessToken: String!
    var accessSecret: String!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    class var sharedInstance : PkkupClient {
        struct Static {
            static let instance = PkkupClient(
                baseURL: NSURL(string: PKKUP_API_BASE_URL)!,
                consumerKey: nil,
                consumerSecret: nil
            )
        }
        return Static.instance
    }

    override init(baseURL: NSURL, consumerKey: String!, consumerSecret: String!) {
        super.init(baseURL: baseURL, consumerKey: consumerKey, consumerSecret: consumerSecret)
    }

    func login(url: String, path: String, completion: (user: PkkupPlayer?, error: NSError?) -> Void) {
        // perform any logout actions before trying to log in
        self.logout()

        self.loginCompletion = completion

        // Fetch request token & redirect to authorization page
//        self.fetchRequestTokenWithPath(
//            TWITTER_API_OAUTH1_REQUEST_TOKEN_RESOURCE,
//            method: "GET",
//            callbackURL: NSURL(string:"\(url)://\(path)"),
//            scope: nil,
//            success: {
//                (requestToken: BDBOAuthToken!) -> Void in
//                NSLog("Got the request token")
//                var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
//                UIApplication.sharedApplication().openURL(authURL)
//            }, failure: {
//                (error: NSError!) -> Void in
//                NSLog("Error getting the request token: \(error)")
//                self.loginCompletion?(user: nil, error: error)
//            }
//        )
    }
    
    func logout() {
        PkkupClient.sharedInstance.requestSerializer.removeAccessToken()
    }
    
    func openURL(url: NSURL) {
        // called by AppDelegate.application(..., openURL: ...)
//        self.fetchAccessTokenWithPath(
//            TWITTER_API_OAUTH1_ACCESS_TOKEN_RESOURCE,
//            method: "POST",
//            requestToken: BDBOAuthToken(queryString: url.query),
//            success: {
//                (accessToken: BDBOAuthToken!) -> Void in
//                NSLog("Got the access token")
//                self.requestSerializer.saveAccessToken(accessToken)
//                self.verifyCredentials()
//            }, failure: {
//                (error: NSError!) -> Void in
//                NSLog("Failed to receive access token")
//                self.loginCompletion?(user: nil, error: error)
//            }
//        )
    }

    func makeApiRequest(resource: String, callback: (AnyObject) -> ()) {
        var apiUrl = "\(PKKUP_API_BASE_URL)\(resource)"
        // temporarily include App key to increase rate limit
        apiUrl = "\(apiUrl)?api_key=secret"
        let request = NSMutableURLRequest(URL: NSURL(string: apiUrl)!)
        NSLog("Hitting API: \(apiUrl)")
        
        var cachedResult: AnyObject? = cache[apiUrl]
        if cachedResult != nil {
            callback(cachedResult!)
        } else {
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response, data, error) in
                var errorValue: NSError? = nil
                let result: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue)
                if result != nil {
                    callback(result!)
                    self.cache[apiUrl] = result!
                } else {
                    HTKNotificationUtils.displayNetworkErrorMessage()
                }
            })
        }
    }

    class func getSports() {
        PkkupClient.sharedInstance.makeApiRequest("/sports/list", callback: {
            (result: AnyObject) -> () in
            var responseDictionary = result as NSDictionary
            var sportDictionaries = responseDictionary["sports"] as [NSDictionary]
            var sports = PkkupSport.sportsWithArray(sportDictionaries)
            PkkupSport.sports = sports
            _SPORTS = sports
            println("Got \(sports.count) sports")
        })
    }

    class func getGames() {
        PkkupClient.sharedInstance.makeApiRequest("/games/list", callback: {
            (result: AnyObject) -> () in
            var responseDictionary = result as NSDictionary
            var gameDictionaries = responseDictionary["games"] as [NSDictionary]
            var games = PkkupGame.gamesWithArray(gameDictionaries)
            _GAMES = games
            println("Got \(games.count) games")
        })
    }

    class func getLocations() {
        PkkupClient.sharedInstance.makeApiRequest("/locations/list", callback: {
            (result: AnyObject) -> () in
            var responseDictionary = result as NSDictionary
            var locationDictionaries = responseDictionary["locations"] as [NSDictionary]
            var locations = PkkupLocation.locationsWithArray(locationDictionaries)
            _LOCATIONS = locations
            println("Got \(locations.count) locations")
        })
    }

    class func getPlayers() {
        PkkupClient.sharedInstance.makeApiRequest("/players/list", callback: {
            (result: AnyObject) -> () in
            var responseDictionary = result as NSDictionary
            var playerDictionaries = responseDictionary["players"] as [NSDictionary]
            var players = PkkupPlayer.playersWithArray(playerDictionaries)
            _PLAYERS = players
            println("Got \(players.count) players")
        })
    }
}
