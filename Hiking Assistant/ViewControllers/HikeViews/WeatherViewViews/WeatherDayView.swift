//
//  WeatherDayView.swift
//  Hiking Assistant
//
//  Created by Daniel on 7/4/25.
//
import SwiftUI

struct WeatherDayView : View {
    
    private var dayOfWeek : String
    private var imageName : String
    private var temp : Int
    
    init(dayOfWeek: String, imageName: String, temp: Int) {
        self.dayOfWeek = dayOfWeek
        self.imageName = imageName
        self.temp = temp
    }
    
    var body: some View {
        VStack {
            Text(self.dayOfWeek)
                .font(.system(size: 16, weight: .medium, design: .default))
                .foregroundColor(.white)
            Image(systemName: self.imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            
            Text("\(self.temp)°C")
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(.white)
        }
    }
}
