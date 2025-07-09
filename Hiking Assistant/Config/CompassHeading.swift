//
//  CompassHeading.swift
//  Hiking Assistant
//
//  Created by Daniel on 7/6/25.
//
import CoreLocation

class CompassHeading : NSObject, CLLocationManagerDelegate, ObservableObject {
    private let locationManager = CLLocationManager()
    
    @Published var magneticHeading : Double
    @Published var realHeading : Double
    @Published var smoothHeading : Double
    
    private var lastHeading : Double
    
    override init() {
        self.magneticHeading = 0.0
        self.realHeading = 0.0
        self.smoothHeading = 0.0
        self.lastHeading = 0.0
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
        let newMagnetic = newHeading.magneticHeading
        let newReal = newHeading.trueHeading
        
        print("Magnetic heading: \(newHeading.magneticHeading)")
        print("Real heading: \(newHeading.trueHeading)")
        
        self.magneticHeading = newMagnetic
        self.realHeading = newReal
        
        let smoothed = smoothTransition(from: lastHeading, to: newMagnetic)
        lastHeading = smoothed
        self.smoothHeading = smoothed
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Failed to get location: \(error.localizedDescription)")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("Authorization changed: \(manager.authorizationStatus.rawValue)")
    }
    
    private func smoothTransition(from previous: Double, to current: Double) -> Double {
            let delta = current - previous
            if abs(delta) <= 180 {
                return current
            }
            else {
                return delta > 0 ? current - 360 : current + 360
            }
        }
    
    func setMagneticHeading(_ setMagneticHeading : Double) -> Void {
        self.magneticHeading = setMagneticHeading
    }
    
    func setSmoothHeading(_ setSmoothHeading : Double) -> Void {
        self.smoothHeading = setSmoothHeading
    }
}
