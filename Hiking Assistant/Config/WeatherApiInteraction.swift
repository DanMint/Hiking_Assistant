//
//  WeatherApiInteraction.swift
//  Hiking Assistant
//
//  Created by Daniel on 7/3/25.
//
import Foundation
import SwiftUI
import CoreLocation

// NSObject: defualt objecgive C things
// CLLocationManagerDelegate: has to do with location
class WeatherApiInteraction: NSObject, CLLocationManagerDelegate {
    private let API_KEY : String = "787bf3527117ccf4f1b1bbda0ace2804"
    @Published var temperatureText : String = "Loading ..."
    @AppStorage("temperatureUnit") private var temperatureUnit : String = "Celcius"
    private var currentTempratureInt : Int = Int(INT32_MAX)
    private let locationManager = CLLocationManager()
    
    // using override beacuse NSObject has its own init so we need to override, bascially we are replacing or extending the behavior of a method from the superclass
    override init() {
        // when calling override ALWAYS call super.init. It basically calls the initializer of the parent class, which is NSObject
        super.init()
        // this is a delegate, meaning it does a job on behalf os something else. When the location changes then locationManager gets envoked automatically
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            fetchWeather(lat, lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        temperatureText = "Failed to get location"
    }
}

extension WeatherApiInteraction : ObservableObject {
    func fetchWeather(_ lat : Double, _ lon : Double) {
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(API_KEY)"
        // guard is used to make sure that the above url confirms to the real URL standerd 
        guard let urlString = URL(string:url) else {return}
        let task = URLSession.shared.dataTask(with: urlString) { data, response, error in
                if let data = data,
                   let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let main = json["main"] as? [String: Any],
                   let temp = main["temp"] as? Double {
                    print(temp)
                    let tempText = self.temperatureUnit == "Celcius" ? "\(Int(temp))°C" : "\(Int(temp * 9 / 5 + 32))°F"

                    DispatchQueue.main.async {
                        self.temperatureText = tempText
                        self.currentTempratureInt = Int(temp)
                    }
                }
            }

            task.resume()
    }
    
    func changeTempratureUnits(_ updatedUnit: String) {
        if self.currentTempratureInt == Int(INT32_MAX) {
            self.temperatureText = "Loading ..."
            return
        }

        if updatedUnit == "Celcius" {
            self.temperatureText = "\(self.currentTempratureInt)°C"
        } else {
            let f = Int(Double(self.currentTempratureInt) * 9 / 5 + 32)
            self.temperatureText = "\(f)°F"
        }
    }
}
