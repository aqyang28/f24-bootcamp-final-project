//
//  HomePage.swift
//  Photo Booking
//
//  Created by Alex Yang on 12/2/24.
//

import SwiftUI

struct HomeTab: View {
    @State private var search: String = ""
    let categories: [String] = ["Graduation", "Sports", "Weddings", "Concerts", "Family"]
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .center, spacing: 8) {
                HStack {
                    Text("Booking101")
                        .bold()
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                    Spacer()
                    Image(systemName: "bell.badge")
                    NavigationLink(destination: BookingsTab()) {
                        Image(systemName: "cart")
                            .overlay(
                                Text("1")
                                    .font(.caption2)
                                    .foregroundColor(.white)
                                    .padding(5)
                                    .background(Circle().fill(.red))
                                    .frame(width: 40, height: 40, alignment: .topTrailing)
                            )
                    }
                    .foregroundStyle(.defaultBlack)
                }
                .padding(.horizontal)
                
                TextField("Search for a photographer", text: $search)
                    .padding(.leading, 35)
                    .padding(.vertical, 10)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .fill(.defaultLightGrey))
                    .foregroundStyle(.defaultBlack)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(.defaultBlack)
                                .padding(.leading, 8)
                            Spacer()
                        }
                    )
                    .padding(.horizontal)
                
                
                Tabs()
                    .padding()
                    .tabViewStyle(PageTabViewStyle())
                
                Divider()
                    .frame(height: 8)
                    .background(.defaultLightGrey)
                HStack {
                    Text("Browse by category")
                        .bold()
                        .foregroundStyle(.defaultBlack)
                    Spacer()
                    Text("Show all")
                        .underline()
                        .foregroundStyle(.defaultBlue)
                }
                .padding()
                
                ForEach(categories, id: \.self) { category in
                    Text(category)
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 10)
                            .fill(.defaultLightPurple)
                            )
                }
                .padding(.horizontal)
                .frame(alignment: .center)

            }
        }
    }
}


#Preview {
    HomeTab()
}
