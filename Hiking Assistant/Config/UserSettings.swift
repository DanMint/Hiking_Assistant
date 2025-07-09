//
//  UserSettings.swift
//  Hiking Assistant
//
//  Created by Daniel on 7/1/25.
//
import Foundation

class UserSettings {
    class func SetTemperatureUnit(celcius: Bool) {
        if celcius {
            UserDefaults.standard.set(true, forKey: "TemperatureUnitCelcius")
        }
        else {
            UserDefaults.standard.set(false, forKey: "TemperatureUnitCelcius")
        }
    }
    
    class func GetTemperatureUnitCelcius() -> Bool {
        return UserDefaults.standard.bool(forKey: "TemperatureUnitCelcius")
    }
}
