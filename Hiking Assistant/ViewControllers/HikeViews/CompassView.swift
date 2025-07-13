import SwiftUI
import CoreLocation

// MARK: - CompassView

struct CompassView: View {
    @ObservedObject var compassHeading : CompassHeading
    
    var body: some View {
        GeometryReader { geo in
            let size = min(geo.size.width, geo.size.height)
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                    .frame(width: size, height: size)
                
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 2, height: size / 2)
                    .offset(y: -size / 4)
                    .rotationEffect(Angle(degrees: compassHeading.smoothHeading))
                    .animation(.easeInOut(duration: 0.2), value: compassHeading.smoothHeading)
                
                Text("\(compassHeading.magneticHeading, specifier: "%.1f")°")
                    .offset(y: size / 2.5)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .aspectRatio(contentMode: .fit)
    }
}


// MARK: - Preview
class MockCompassHeading : CompassHeading {
    // Swift does not auto inherit the intializers of the parent class.
    // Override needed here becuase parent calss has its own init
    override init() {
        // here the parent init is called
        super.init()
        setMagneticHeading(42)
        setSmoothHeading(42)
    }
}


#Preview {
   CompassView(compassHeading: MockCompassHeading())
}
