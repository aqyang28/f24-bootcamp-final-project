//
//  ContentView.swift
//  Photo Booking
//
//  Created by Alex Yang on 11/12/24.
//

import SwiftUI

struct ContentView: View {
//    @State private var text = "begin"
//    @State private var appear = false
    @State private var isVisible = false

    
    var body: some View {

        HStack {
                Image("logo")
                Text("Booking101")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .onAppear {
                        withAnimation(.easeIn(duration: 0.8)) {
                            isVisible = true
                        }
                    }
            }
        .opacity(isVisible ? 1 : 0)
    }
}

#Preview {
    ContentView()
}

