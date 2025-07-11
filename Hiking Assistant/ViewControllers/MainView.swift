//
//  MainView.swift
//  Hiking Assistant
//
//  Created by Daniel on 6/29/25.
//

import SwiftUI

struct MainView: View {
    // StateObject of compass heading to be passed around
    @StateObject var compassHeading : CompassHeading = CompassHeading()
    @StateObject var weatherApiInteraction : WeatherApiInteraction = WeatherApiInteraction()
    
    // Simple greetins
    private let greeings : [String] = [
        "Have a good day",
        "Have a great day",
        "Enjoy your day",
        "Hope your day goes well",
        "Make it a good one",
        "Have a lovely day",
        "Take care today"
    ]
    
    // randomizer for greetings
    private let randomIndex = Int.random(in: 0...6)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    Text(self.greeings[randomIndex])
                        .font((.system(size: 32, weight: .medium, design: .default)))
                        .aspectRatio(contentMode: .fit)
                        .padding(.horizontal)
                    NavigationLink(destination: FullCompassView(compassHeading: self.compassHeading)) {
                        CompassView(compassHeading: self.compassHeading)
                            .aspectRatio(1, contentMode: .fit)
                            .padding(.horizontal)
                    }
                    
                    NavigationLink(destination: FullMapView()) {
                        MapView()
                            .aspectRatio(1, contentMode: .fit)
                            .cornerRadius(20)
                            .padding(.horizontal)
                    }
                    
                    NavigationLink(destination: FullWeatherView()) {
                        WeatherView()
                            .aspectRatio(1, contentMode: .fit)
                            .cornerRadius(20)
                            .padding(.horizontal)
                    }
                }
            }
            .background(Color("MainBackground"))
        }
    }
}
    
#Preview {
    MainView()
        .environmentObject(WeatherApiInteraction())
}
