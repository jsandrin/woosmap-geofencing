//
//  AppDelegate.swift
//  GeoSearch
//
//

import UIKit
import CoreData
import CoreLocation
import GeoSearchSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Set private key Search API
        GeoSearch.shared.setWoosmapAPIKey(key: "YOUR_WOOSMAP_API_KEY")
        
        // Set your filter on position location and search
        GeoSearch.shared.setCurrentPositionFilter(distance: 10.0, time: 10)
        GeoSearch.shared.setSearchAPIFilter(distance: 10.0, time: 10)
        
        // Initialize the framework
        GeoSearch.shared.initServices()
        
        // Set delegate of protocol Location and POI
        GeoSearch.shared.getLocationService().locationServiceDelegate = DataLocation()
        GeoSearch.shared.getLocationService().searchAPIDataDelegate = DataPOI()
        
        // Check if the authorization Status of location Manager
        if (CLLocationManager.authorizationStatus() != .notDetermined) {
            GeoSearch.shared.startMonitoringInBackground()
        }
        
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        if (CLLocationManager.authorizationStatus() != .notDetermined) {
            GeoSearch.shared.startMonitoringInBackground()
        }
        
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        GeoSearch.shared.didBecomeActive()
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Location")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

