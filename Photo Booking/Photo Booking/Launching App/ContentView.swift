//
//  ContentView.swift
//  Photo Booking
//
//  Created by Alex Yang on 11/12/24.
//

import SwiftUI

//struct ContentView: View {
////    @State private var text = "begin"
////    @State private var appear = false
//    @State private var isVisible = false
//
//    
//    var body: some View {
//        NavigationStack {
//            VStack {
//                HStack {
//                    Image("logo")
//                    Text("Booking101")
//                        .font(.largeTitle)
//                        .fontWeight(.bold)
//                        .onAppear {
//                            withAnimation(.easeIn(duration: 0.8)) {
//                                isVisible = true
//                            }
//                        }
//                }
//                .opacity(isVisible ? 1 : 0)
//                
//                NavigationLink(destination: BeginView()) {
//                    Text("Click to begin")
//                }
//                .padding()
//                .background(.defaultPurple)
//                .cornerRadius(10)
//                .padding()
//                .foregroundStyle(.white)
//                
//            }
//        }
//    }
//}

struct ContentView: View {
    @State private var isVisible = false
    @State private var navigateToNextView = false
    @Binding var numBookings: Int

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Image("logo")
                    Text("Booking101")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .onAppear {
                            withAnimation(.easeIn(duration: 1.0)) {
                                isVisible = true
                            }
                            // Delay navigation by 2 seconds after animation
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                                navigateToNextView = true
                            }
                        }
                }
                .opacity(isVisible ? 1 : 0)
            }
            .background(
                NavigationLink(destination: BeginView(numBookings: $numBookings), isActive: $navigateToNextView) {
                    EmptyView()
                }
            )
        }
    }
}

#Preview {
    ContentView(numBookings: .constant(0))
}

