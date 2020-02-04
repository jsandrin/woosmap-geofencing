//
//  AppDelegate.swift
//  LocationNotification
//
//  Created by Mac de Laurent on 02/01/2020.
//  Copyright © 2020 Laurent L. All rights reserved.
//

import UIKit
import UserNotifications
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    var locationManager:CLLocationManager!
    weak var viewController : ViewController? 


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
        if #available(iOS 10, *) {
            UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
            UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]) { granted, error in }
        } else {
            application.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
        }
        application.registerForRemoteNotifications()
        
        setupLocationManager()

        return true
    }
    
    func setupLocationManager(){
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        self.locationManager?.requestAlwaysAuthorization()
        locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
    }
    
    // Handle remote notification registration. (succes)
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data){
        let tokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        print("this will return '32 bytes' in iOS 13+ rather than the token \(tokenString)")
        NSLog("%%%%% THE the token: %@", tokenString);
        viewController?.loadRequest(for: tokenString)
    }
    
    // Handle remote notification registration. (failed)
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        NSLog("Error on getting remote notification token : \(error.localizedDescription)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> ())
    {
        NSLog("%%%%% didReceiveRemoteNotification");
        if ( application.applicationState == UIApplication.State.inactive || application.applicationState == UIApplication.State.background ){
            
        }
    }

}

