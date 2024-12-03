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
    
    private let decoder = JSONDecoder()
    
    public func fetchUsers() async throws -> [User] {
        let components = URLComponents(string: "http://127.0.0.1:5001/get_users")
        guard let url = components?.url else {
            return [] }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let users = try JSONDecoder().decode([User].self, from: data)
        return users
    }
    
    public func validateUser(username: String, password: String) async throws -> Bool {
            var components = URLComponents(string: "http://127.0.0.1:5001/validate_user")
                components?.queryItems = [
                    URLQueryItem(name: "username", value: username),
                    URLQueryItem(name: "password", value: password)
                ]
            
            guard let url = components?.url else {
                throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            }
            
            let (_, response) = try await URLSession.shared.data(from: url)
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                return true
            }
            throw NSError(domain: "Invalid credentials", code: 1, userInfo: nil)
        }
    
    public func addUser(name: String, email: String, username: String, password: String) async throws -> String {
            guard let url = URL(string: "http://127.0.0.1:5001/add_user") else {
                throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            }
            
            let userData: [String: String] = [
                "name": name,
                "email": email,
                "username": username,
                "password": password
            ]
            
            let jsonData = try JSONSerialization.data(withJSONObject: userData, options: [])
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            let (_ , response) = try await session.data(for: request)
            
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
