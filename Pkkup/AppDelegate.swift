//
//  AppDelegate.swift
//  Pkkup
//
//  Copyright (c) 2014 Pkkup. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    var locationManager = CLLocationManager()
    var storyboard = UIStoryboard(name: "Main", bundle: nil)

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "userDidLogout", name: PKKUP_USER_DID_LOGOUT_NOTIFICATION, object: nil)

        PkkupClient.getSports()
        PkkupClient.getLocations()
        PkkupClient.getGames()
        PkkupClient.getPlayers()

        if PkkupPlayer.currentPlayer != nil {
            // Go to the logged in screen
            NSLog("Current player detected: \(PkkupPlayer.currentPlayer?.name)")
            var vc = storyboard.instantiateViewControllerWithIdentifier("PkkupNavigationController") as UIViewController
            window?.rootViewController = vc
        }
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        //locationManager.stopUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        
        return true
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var location = locations[0] as CLLocation
        NSNotificationCenter.defaultCenter().postNotificationName("didUpdateLocationNotification", object: nil, userInfo: ["location" : location])
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        locationManager.stopUpdatingLocation()
        if ((error) != nil) {
            println("Error : \(error)")
        }
    }

    func userDidLogout() {
        var vc = storyboard.instantiateInitialViewController() as UIViewController
        window?.rootViewController = vc
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String, annotation: AnyObject?) -> Bool {
        PkkupClient.sharedInstance.openURL(url)
        return true
    }
}

