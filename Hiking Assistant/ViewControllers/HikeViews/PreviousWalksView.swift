//
//  PreviousWalksView.swift
//  Hiking Assistant
//
//  Created by Daniel on 6/29/25.
//

import SwiftUI

struct PreviousWalksView : View {
    var body : some View {
        NavigationStack {
            VStack {
                Text("There are no previous views")
                Spacer()
                NavigationLink(destination: AddNewWalkView()) {
                    HStack {
                        Image(systemName: "plus.app")
                        Text("Add new walk")
                    }
                    .padding()
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
        }
    }
}

#Preview {
    PreviousWalksView()
}
