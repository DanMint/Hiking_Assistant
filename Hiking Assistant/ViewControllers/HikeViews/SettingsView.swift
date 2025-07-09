//
//  Settings.swift
//  Hiking Assistant
//
//  Created by Daniel on 6/27/25.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("temperatureUnit") private var temperatureUnit : String = "Celcius"
    @EnvironmentObject var weatherAPI : WeatherApiInteraction
    
    var body: some View {
        Form {
            Section(header: Text("Temperature Unit")) {
                Picker("Unit: ", selection: $temperatureUnit) {
                    Text("Celcius").tag("Celcius")
                    Text("Fahrenheit").tag("Fahrenheit")
                }
                .onChange(of: temperatureUnit) {
                    newValue in weatherAPI.changeTempratureUnits(newValue)
                }
            }
        }
        .navigationTitle("Settings")
    }
}
