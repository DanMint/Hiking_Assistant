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
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Text("Compass View")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 32, weight: .heavy, design: .default))
                        .padding()
                    Spacer()
                    Spacer()
                    CompassView(compassHeading: self.compassHeading)
                        .frame(maxWidth: 360, maxHeight: 360)
                        .padding(.top, 40)
                        .padding(.bottom, 40)
                    
                    VStack {
                        ZStack {
                            Rectangle()
                                .fill(Color.blue)
                                .frame(width: geometry.size.width * 0.95, height: geometry.size.height * 0.21)
                                .cornerRadius(10)

                            Text("Altitude")
                                .font(.system(size: 30))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                .padding(.top, 20)
                                .padding(.leading, 30)
                            
                            Text("\(compassHeading.altitude)")
                                .font(.system(size: 30))
                                .padding(.top, 40)
                                
                        }
                        
                        ZStack {
                            Rectangle()
                                .fill(Color.blue)
                                .frame(width: geometry.size.width * 0.95, height: geometry.size.height * 0.21)
                                .cornerRadius(10)

                            Text("Magnetic Heading")
                                .font(.system(size: 30))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                .padding(.top, 20)
                                .padding(.leading, 30)
                            
                            Text("\(compassHeading.magneticHeading)")
                                .font(.system(size: 30))
                                .padding(.top, 40)
                                
                        }
                        
                        ZStack {
                            Rectangle()
                                .fill(Color.blue)
                                .frame(width: geometry.size.width * 0.95, height: geometry.size.height * 0.21)
                                .cornerRadius(10)

                            Text("Speed")
                                .font(.system(size: 30))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                .padding(.top, 20)
                                .padding(.leading, 30)
                            
                            Text("\(compassHeading.speed)")
                                .font(.system(size: 30))
                                .padding(.top, 40)
                                
                        }
                    }
                    Spacer()
                }
            }
        }
        .background(Color("MainBackground"))
    }
}

// MARK: Test heading class to have a preiew
class TestCompassHeading : CompassHeading {
    override init() {
        super.init()
        setSmoothHeading(50)
        setMagneticHeading(50)
    }
}

#Preview {
    FullCompassView(compassHeading: TestCompassHeading())
}
