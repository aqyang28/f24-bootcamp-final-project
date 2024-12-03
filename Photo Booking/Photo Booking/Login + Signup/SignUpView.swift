//
//  SignUpView.swift
//  Photo Booking
//
//  Created by Alex Yang on 11/30/24.
//

import SwiftUI

struct SignUpView: View {
    @State private var name: String = ""
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?
    @State private var successMessage: String?
    @State private var isLoggedIn: Bool = false
    @Binding var numBookings: Int
    
    var body: some View {
        
        NavigationStack {
            
            VStack (alignment: .leading, spacing: 10) {
                Text("Welcome!")
                    .font(.largeTitle)
                    .bold()
                
                HStack {
                    Text("Already have an account?")
                        .foregroundStyle(.secondary)
                    NavigationLink (destination: LoginView(numBookings: $numBookings)) {
                        Text("Log in here")
                            .underline()
                    }
                }
                .font(.callout)
                .padding(.bottom, 40)
                
                Text("Name")
                TextField("enter name", text: $name)
                    .foregroundStyle(.secondary)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10)
                        .stroke(.defaultPurple, lineWidth: 2))
                    .padding(.bottom, 15)

                Text("Email")
                TextField("enter email", text: $email)
                    .foregroundStyle(.secondary)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10)
                        .stroke(.defaultPurple, lineWidth: 2))
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .padding(.bottom, 15)
                
                Text("Username")
                TextField("create username", text: $username)
                    .foregroundStyle(.secondary)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10)
                        .stroke(.defaultPurple, lineWidth: 2))
                    .textInputAutocapitalization(.never)
                    .padding(.bottom, 15)
                
                Text("Password")
                SecureField("create password", text: $password)
                    .foregroundStyle(.secondary)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10)
                        .stroke(.defaultPurple, lineWidth: 2))
                    .textInputAutocapitalization(.never)
                    .padding(.bottom, 20)
                
                Button("Sign Up") {
                    Task {
                        await signUpUser()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10)
                    .fill(.defaultPurple))

                .foregroundStyle(.white)
                
                .background(NavigationLink(destination: HomeView( numBookings: $numBookings), isActive: $isLoggedIn) {
                   Text("Sign Up")
                })
                .disabled(name == "" || email == "" || password == "")
                .padding(.bottom, 20)
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                
                if let successMessage = successMessage {
                    Text(successMessage)
                        .foregroundColor(.green)
                }
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 75)
        }
        .navigationBarBackButtonHidden()
    }
    
    private func signUpUser() async {
        do {
            let message = try await UserService().addUser(name: name, email: email, username: username, password: password)
            successMessage = message
            errorMessage = nil
            isLoggedIn.toggle()
        } catch {
            successMessage = nil
            errorMessage = error.localizedDescription
        }
    }
}

#Preview {
    SignUpView(numBookings: .constant(0))
}
