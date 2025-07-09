//
//  WeatherView.swift
//  Hiking Assistant
//
//  Created by Daniel on 6/20/25.
//

import SwiftUI
import CoreLocation

struct WeatherView: View {
    @AppStorage("temperatureUnit") private var temperatureUnit : String = "Celcius"
    
    @EnvironmentObject var weatherAPI : WeatherApiInteraction
    
    var body: some View {
        // we use ZStack here because we want to have depth (namely background, etc). ZStack vertical view hierchy, layers
        ZStack {
            // gradiant makes it not one solid color but makes it chnage colors, You can add as many colors is needed
            LinearGradient(gradient: Gradient(colors: [.blue, Color("LightBlue")]),
                           startPoint: .topLeading,
                           endPoint: .bottomLeading)
                //this is known as a modifire
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Boston, MA")
                    //more modifiers. Modifiers are a view wrapping another view
                    .font(.system(size: 32, weight: .medium, design: .default))
                    .foregroundColor(.white)
                    .padding()
                
                VStack(spacing: 8) {
                    Image(systemName: "cloud.sun.fill")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 180, height: 180)
                    
                    Text("28°C")
                        .font(.system(size: 70, weight: .medium))
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                HStack(spacing: 20) {
                    WeatherDayView(dayOfWeek: "TUE", imageName: "cloud.sun.fill", temp: 28)
                    WeatherDayView(dayOfWeek: "WED", imageName: "cloud.sun.fill", temp: 28)
                    WeatherDayView(dayOfWeek: "THU", imageName: "cloud.sun.fill", temp: 28)
                    WeatherDayView(dayOfWeek: "FRI", imageName: "cloud.sun.fill", temp: 28)
                    WeatherDayView(dayOfWeek: "SAT", imageName: "cloud.sun.fill", temp: 28)
                }
                // Spacer is like a spring. If VStack spacer pushes it up. Spacer will fill the entire space
                Spacer()
            }
        }
    }
}


#Preview {
    WeatherView()
        .environmentObject(WeatherApiInteraction())
}

