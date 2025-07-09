//
//  FullCompassView.swift
//  Hiking Assistant
//
//  Created by Daniel on 7/6/25.
//

import SwiftUI

struct FullCompassView : View {
    @ObservedObject var compassHeading : CompassHeading
    
    var body : some View {
        VStack {
            Text("Compass View")
            CompassView(compassHeading: self.compassHeading)
        }
    }
}
