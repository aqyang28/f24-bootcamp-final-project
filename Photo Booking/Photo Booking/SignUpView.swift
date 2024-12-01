//
//  SignUpView.swift
//  Photo Booking
//
//  Created by Alex Yang on 11/30/24.
//

import SwiftUI

struct SignUpView: View {
    @State private var email: String = "enter email"
    @State private var password: String = "enter password"
    
    var body: some View {
        
        NavigationStack {
            
            VStack (alignment: .leading, spacing: 10) {
                Text("Welcome Back!")
                    .font(.largeTitle)
                    .bold()
                
                HStack {
                    Text("Don't have an account?")
                        .foregroundStyle(.secondary)
                    NavigationLink (destination: SignUpView()) {
                        Text("Sign up here")
                            .underline()
                    }
                }
                .font(.callout)
                .padding(.bottom, 100)
                
                Text("Email")
                TextField("email", text: $email)
                    .foregroundStyle(.secondary)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10)
                        .stroke(.purple, lineWidth: 2))
                
                    .padding(.bottom, 20)
                
                Text("Password")
                TextField("test", text: $password)
                    .foregroundStyle(.secondary)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10)
                        .stroke(.purple, lineWidth: 2))
                
                    .padding(.bottom)
                NavigationLink(destination: HomeView()) {
                    Text("Login")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(in: RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                }
                
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 200)
            
        }
    }
}

#Preview {
    SignUpView()
}
