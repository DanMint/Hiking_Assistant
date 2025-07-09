//
//  CompassView.swift
//  Hiking Assistant
//
//  Created by Daniel on 6/20/25.
//

import SwiftUI
import CoreLocation

struct CompassView: View {
    @StateObject private var viewModel = CompassViewModel()

    var body: some View {
        ZStack {
            Color.yellow.edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                ZStack {
                    Image("Compass")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .aspectRatio(contentMode: .fit)

                    Image("compass needle")
                        .resizable()
                        .frame(width: 50, height: 100)
                        .rotationEffect(.degrees(viewModel.headingRotation))
                        .animation(.easeInOut(duration: 0.3), value: viewModel.headingRotation)
                }

                Text(viewModel.headingText)
                    .font(.title)
            }
        }
        .onAppear {
            viewModel.start()
        }
    }
}

class CompassViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var headingText: String = "Heading: --"
    @Published var headingRotation: Double = 0

    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.headingFilter = kCLHeadingFilterNone
    }

    func start() {
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.headingAvailable() {
            locationManager.startUpdatingHeading()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        let degrees = newHeading.magneticHeading
        let direction = directionFrom(degrees)
        headingText = String(format: "Heading: %.1f° %@", degrees, direction)
        headingRotation = -degrees
    }

    private func directionFrom(_ heading: CLLocationDirection) -> String {
        switch heading {
        case 0..<22.5, 337.5...360: return "N"
        case 22.5..<67.5: return "NE"
        case 67.5..<112.5: return "E"
        case 112.5..<157.5: return "SE"
        case 157.5..<202.5: return "S"
        case 202.5..<247.5: return "SW"
        case 247.5..<292.5: return "W"
        case 292.5..<337.5: return "NW"
        default: return "?"
        }
    }
}

#Preview {
    ContentView()
}
