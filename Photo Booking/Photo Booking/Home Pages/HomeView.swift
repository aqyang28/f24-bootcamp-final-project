//
//  HomeView.swift
//  Photo Booking
//
//  Created by Alex Yang on 11/30/24.
//

import SwiftUI

struct HomeView: View {
    @State var selectedTab: Int = 0
    @Binding var numBookings: Int
    
    var body: some View {
        
        TabView {
                HomeTab()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                    .tag(0)
            SearchTab(numBookings: $numBookings)
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                    .tag(1)
                BookingsTab()
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text("Bookings")
                    }
                    .tag(2)
                ProfileTab()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
                    .tag(3)
            }
            .tint(.defaultPurple)
            .navigationBarBackButtonHidden()
        }
    }

#Preview {
    HomeView(numBookings: .constant(0))
}
