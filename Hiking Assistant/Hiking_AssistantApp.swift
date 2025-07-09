//
//  Hiking_AssistantApp.swift
//  Hiking Assistant
//
//  Created by Daniel on 6/15/25.
//

import SwiftUI

@main
struct Hiking_AssistantApp: App {
    // Instance created for weatherAPI (parent view)
    @StateObject private var weatherAPI = WeatherApiInteraction()
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
