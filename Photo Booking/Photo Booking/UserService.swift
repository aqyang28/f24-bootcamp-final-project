//
//  UserService.swift
//  Photo Booking
//
//  Created by Alex Yang on 12/1/24.
//

import Foundation
import SwiftUI


struct UserService {
    private let session = URLSession.shared
    
    /// Used to decode the data we receive from `JSON`
    private let decoder = JSONDecoder()
    
    /// Fetch the name of a random iOS Bootcamp member from `learning.appteamcarolina.com`
    /// - Returns: A string containing an apprentice's name.
    public func fetchUsers() async throws -> [User] {
        // Build the URL we'll make a request to
        let components = URLComponents(string: "http://127.0.0.1:5001/get_users")
        guard let url = components?.url else {
            return [] }
        
        // Begin fetching the data and wait for the response to come back
        let (data, _) = try await URLSession.shared.data(from: url)
        
        // Decode the name as a String from the `Data` type using our `JSONDecoder`
        let users = try JSONDecoder().decode([User].self, from: data)
        // Return the decoded name
        return users
    }
    
    public func validateUser(username: String, password: String) async throws -> Bool {
            // Build the URL for the validate_user endpoint
            var components = URLComponents(string: "http://127.0.0.1:5001/validate_user")
                components?.queryItems = [
                    URLQueryItem(name: "username", value: username),
                    URLQueryItem(name: "password", value: password)
                ]
            
            guard let url = components?.url else {
                throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            }
            
            // Begin fetching the data and wait for the response to come back
            let (_, response) = try await URLSession.shared.data(from: url)
            
            // Check for successful login
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                return true
            }
            // If unsuccessful, throw an error
            throw NSError(domain: "Invalid credentials", code: 1, userInfo: nil)
        }
    
    public func addUser(name: String, email: String, username: String, password: String) async throws -> String {
            // Build the URL
            guard let url = URL(string: "http://127.0.0.1:5001/add_user") else {
                throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            }
            
            // Prepare the user data as a dictionary
            let userData: [String: String] = [
                "name": name,
                "email": email,
                "username": username,
                "password": password
            ]
            
            // Serialize the dictionary to JSON data
            let jsonData = try JSONSerialization.data(withJSONObject: userData, options: [])
            
            // Create the URLRequest
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            // Perform the request
            let (_ , response) = try await session.data(for: request)
            
            // Check the HTTP status code
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 201:
                    return "User added successfully"
                case 409:
                    throw NSError(domain: "Conflict: Username already exists", code: 409, userInfo: nil)
                case 400:
                    throw NSError(domain: "Bad Request: Missing required fields", code: 400, userInfo: nil)
                default:
                    throw NSError(domain: "Unexpected status code: \(httpResponse.statusCode)", code: httpResponse.statusCode, userInfo: nil)
                }
                } else {
                    throw NSError(domain: "Invalid response", code: 0, userInfo: nil)
                }
        }
}
