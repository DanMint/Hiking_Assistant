import SwiftUI
import CoreLocation

// MARK: - CompassView

struct CompassView: View {
    @ObservedObject var compassHeading : CompassHeading
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                .frame(width: 200, height: 200)
            
            Rectangle()
                .fill(Color.red)
                .frame(width: 2, height: 100)
                .offset(y: -50)
                .rotationEffect(Angle(degrees: compassHeading.smoothHeading))
                .animation(.easeInOut(duration: 0.2), value: compassHeading.smoothHeading)

            Text("\(compassHeading.magneticHeading, specifier: "%.1f")°")
                .offset(y: 80)
        }
        .aspectRatio(contentMode: .fit)
    }
}


// MARK: - Preview
class MockCompassHeading: CompassHeading {
    override init() {
        super.init()
        setMagneticHeading(42)
        setSmoothHeading(42)
    }
}


#Preview {
   CompassView(compassHeading: MockCompassHeading())
}
