//
//  LoginView.swift
//  Photo Booking
//
//  Created by Alex Yang on 11/30/24.
//

import SwiftUI

struct LoginView: View {
    @State private var user: String = ""
    @State private var password: String = ""
    @State private var loginErrorMessage: String?
    @State private var isLoggedIn: Bool = false
    @Binding var numBookings: Int
    
    var body: some View {
        
        NavigationStack {
            
            VStack (alignment: .leading, spacing: 10) {
                Text("Welcome Back!")
                    .font(.largeTitle)
                    .bold()
                
                HStack {
                    Text("Don't have an account?")
                        .foregroundStyle(.secondary)
                    NavigationLink (destination: SignUpView(numBookings: $numBookings)) {
                        Text("Sign up here")
                            .underline()
                    }
                }
                .font(.callout)
                .padding(.bottom, 100)
                
                Text("Email or username")
                TextField("enter email or username", text: $user)
                    .foregroundStyle(.secondary)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10)
                        .stroke(.defaultPurple, lineWidth: 2))
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                
                    .padding(.bottom, 20)
                
                Text("Password")
                SecureField("enter password", text: $password)
                    .foregroundStyle(.secondary)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10)
                        .stroke(.defaultPurple, lineWidth: 2))
                    .textInputAutocapitalization(.never)

                
                    .padding(.bottom, 20)
                
                Button("Login") {
                    loginErrorMessage = nil
                    Task {
                        await loginUser()
                    }
                }
                .background(NavigationLink(destination: HomeView( numBookings: $numBookings), isActive: $isLoggedIn) {
                   Text("Login")
                })
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10)
                    .fill(.defaultPurple))
                .foregroundStyle(.white)
                .disabled(user == "" || password == "")
                
                if let errorMessage = loginErrorMessage {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                        .padding(.top, 10)
                }
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 200)
            

        }
        .navigationBarBackButtonHidden()
    }
    private func loginUser() async {
            do {
                //i want to eventually make it so you can enter email or username and have it go through
                let isValid = try await UserService().validateUser(username: user, password: password)
                if isValid {
                    // Navigate to HomeView or whatever next view
                    // You can use a NavigationLink or programmatically trigger the navigation.
                    print("Login successful!")
                    isLoggedIn.toggle()

                } else {
                    loginErrorMessage = "Invalid username or password"
                }
            } catch {
                loginErrorMessage = "Error: invalid username or password"
            }
        }
}

#Preview {
    LoginView(numBookings: .constant(0))
}
