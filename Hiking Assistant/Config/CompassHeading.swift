//
//  CompassCreation.swift
//  Hiking Assistant
//
//  Created by Daniel on 7/6/25.
//
import CoreLocation

class CompassCreation : NSObject, CLLocationManagerDelegate, ObservableObject {
    private let locationManager = CLLocationManager()
    @Published var magneticHeading : Double
    @Published var realHeading : Double
    
    override init() {
        self.magneticHeading = 0.0
        self.realHeading = 0.0
        // super init needed to initialize NSObject
        super.init()
        // this makes sure that the delegate is assosiated with this class instance
        locationManager.delegate = self
        // sets minimum chnage of degree before didUpdate is triggered
        locationManager.headingFilter = 1
        // tells Core Location that compass is intedned to be used in upright position
        locationManager.headingOrientation = .portrait
        // requests user to get location updates
        locationManager.requestWhenInUseAuthorization()
        // this updates the location when user moves phone
        locationManager.startUpdatingHeading()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        print("Magnetic heading: \(newHeading.magneticHeading)")
        print("Real heading: \(newHeading.trueHeading)")
        
        self.magneticHeading = newHeading.magneticHeading
        self.realHeading = newHeading.trueHeading
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Failed to get location: \(error.localizedDescription)")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("Authorization changed: \(manager.authorizationStatus.rawValue)")
    }
}
