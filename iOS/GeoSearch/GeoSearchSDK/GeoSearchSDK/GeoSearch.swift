
import Foundation
import AdSupport
import CoreLocation
import UIKit

/**
        GeoSearch main class. Cannot be instanciated, use `shared` property to access singleton
 */
@objcMembers public class GeoSearch: NSObject {
     
    public var locationService : LocationService!
    var locationManager: CLLocationManager? = CLLocationManager()
    
    /**
     Access singleton of Now object
     */
    public static let shared: GeoSearch = {
        let instance = GeoSearch()
        return instance
    }()
    
    private override init () {
        super.init()
        self.initServices()

    }
    
    public func getLocationService() -> LocationService {
        return locationService
    }

    public func initServices() {
        if self.locationService == nil {
            self.locationService = LocationService(locationManger: self.locationManager)
        }
    }
    
    public func setWoosmapAPIKey(key: String) {
        searchWoosmapKey = key
    }
    
    public func setCurrentPositionFilter(distance: Double, time: Int) {
        currentLocationDistanceFilter = distance
        currentLocationTimeFilter = time
    }
    
    public func setSearchAPIFilter(distance: Double, time: Int) {
        searchAPIDistanceFilter = distance
        searchAPITimeFilter = time
    }
    
    public func startMonitoringInForeGround() {
        if self.locationService == nil  {
            return
        }
        self.locationService?.startUpdatingLocation()
    }
    
    /**
        Call this method from the DidFinishLaunchWithOptions method of your App Delegate
    */
    public func startMonitoringInBackground() {
        if self.locationService == nil  {
            NSLog("GeoSearch is not initiated")
            return
        }
        self.locationService?.startUpdatingLocation()
        self.locationService?.startMonitoringSignificantLocationChanges()
    }
    
    /**
     Call this method from the applicationDidBecomeActive method of your App Delegate
     */
    public func didBecomeActive() {
        if self.locationService == nil  {
            NSLog("GeoSearch is not initiated")
            return
        }
        self.startMonitoringInBackground()
    }

    func trackingChanged(tracking: Bool) {
        if !tracking {
            self._stopAllMonitoring()
        } else {
            self.startMonitoringInBackground()
        }
    }
    
    func _stopAllMonitoring() {
        self.locationService.stopUpdatingLocation()
        self.locationService.stopMonitoringSignificantLocationChanges()
    }
    
    func _logDenied() {
        self._stopAllMonitoring()
        NSLog("User has activated DNT")
    }
    
}
