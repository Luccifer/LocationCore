//
//  LocationCore.swift
//  SurpriseMe
//
//  Created by Gleb Karpushkin on 15/09/2016.
//  Copyright © 2016 SurpriseMe. All rights reserved.
//

import Foundation
import CoreLocation

public protocol LocationProtocol {
    
    var manager: CLLocationManager { get }
    var desiredAccuracy: CLLocationAccuracy { get set }
    var distanceFilter: CLLocationDistance { get set }
    var pausesLocationUpdates: Bool { get set }
    var monitoringAlavialbe: Bool {get set}
    func startUpdating()
    func stopUpdating()
    func monitorNewRegion(_ region: CLCircularRegion)
    func stopMonitorRegion(_ region: CLCircularRegion)
    func getLocationAccuracy() -> String
    init()
}

fileprivate class LocationManagerDelegate: NSObject, CLLocationManagerDelegate {
    
    deinit {
        print("Location Core Deinitialized")
    }
    
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    internal func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        NSLog("\(error)")
    }
    
    internal func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        NSLog("\(error)")
    }
    
    internal func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
    }
    
    internal func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        switch  state {
        case .inside:
            break
        case .outside:
            break
        default:
            break
        }
        
    }
    
    internal func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            break
        case .denied :
            break
        case .notDetermined:
            break
        case .restricted:
            break
        }
    }
    
    
}

struct Location: LocationProtocol {
    
    public var desiredAccuracy: CLLocationAccuracy
    public var distanceFilter: CLLocationDistance
    public var pausesLocationUpdates: Bool
    public var monitoringAlavialbe: Bool
    
    public static var core: LocationProtocol = Location()
    
    public var manager = CLLocationManager()
    fileprivate var managerDelegate = LocationManagerDelegate()
    
    init() {
        self.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        self.distanceFilter = kCLDistanceFilterNone
        self.pausesLocationUpdates = false
        self.monitoringAlavialbe =  CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self)
        manager.delegate = managerDelegate
        manager.allowsBackgroundLocationUpdates = true
        manager.requestAlwaysAuthorization()
    }
    
    public func startUpdating() {
        self.manager.startUpdatingLocation()
    }
    
    public func stopUpdating() {
        self.manager.stopUpdatingLocation()
    }
    
    public func monitorNewRegion(_ region: CLCircularRegion) {
        region.notifyOnEntry = true
        self.manager.startMonitoring(for: region)
    }
    
    public func stopMonitorRegion(_ region: CLCircularRegion) {
        self.manager.startMonitoring(for: region)
    }
    
    public func getLocationAccuracy() -> String {
        
        if (self.manager.location!.horizontalAccuracy < 0)
        {
            print("No Signal")
            return "No Signal".localized
        }
        else if (self.manager.location!.horizontalAccuracy > 163)
        {
            print("Poor Signal")
            return "Poor".localized
        }
        else if (self.manager.location!.horizontalAccuracy > 48)
        {
            print("Average Signal")
            return "Average".localized
        }
        else
        {
            print("Full Signal")
            return "Full".localized
        }
    }

    
}
