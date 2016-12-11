# LocationCore

![](https://img.shields.io/badge/swift-3.0-green.svg)
![](https://img.shields.io/badge/platform-ios-gray.svg)


Working singleton for many projects with maximised power of GeoLocation


# Installation
Simply drag and drop the LocationCore.swift file to your project


# Useful methods
## Start and stop location updates


```swift
// to start location updates just use the following method
Location.core.startUpdating()
```


```swift
// if you wanna to stop using location services
Location.core.stopUpdating()
```


## Region monitoring


```swift
// to start monitoring any area simply use
 Location.core.monitorNewRegion(_ region: CLCircularRegion)
```


```swift
// and to stop monitoring them
 Location.core.stopMonitorRegion(_ region: CLCircularRegion)
```


## Other
```swift
// To get the actual accuracy of geo signal
Location.core.getLocationAccuracy() -> String
// Cases: "No Signal", "Poor Signal", "Average Signal", "Full Signal"
// asuming the values of horizontalAccuracy in comparance with scheme:
// <0(No), >163(Poor) and >48(Average) and other values(Full)
```

## Change configuration and getting values


To change any values of CLLocationManager configuration you should address the core.manager:
```swift
// to change activityType
Location.core.manager.activityType = .fitness
```


Or if you want to get any values from working core:


```swift
// gettin' monitors you are monitoring and didn't removed from observation
Location.core.manager.monitoredRegions
```
