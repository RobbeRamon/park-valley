//
//  UserModelController.swift
//  ParkValley
//
//  Created by Robbe on 21/11/2020.
//

import Foundation

class UserModelController {
    
    
    /// This is method that resets the backend data for EVERY user, only needed for the prototype settings
    func resetBackend(completion: @escaping (StatusDTO?) -> Void) {
        let url = giveURL(path: "/reset")
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
               let status = try? jsonDecoder.decode(StatusDTO.self, from: data) {
                completion(status)
            } else {
                print("Either no data was returned, or data was not properly decoded.")
                
                completion(nil)
                return
            }
        }
        
        task.resume()
    }
    
    /// Login the user in the backend
    /// - Parameters:
    ///     - username: The username of the user to login with
    ///     - password: The password of the user to login with
    /// Returns a UserTokenDTO
    func login(username: String, password: String, completion: @escaping (UserTokenDTO?) -> Void) {
        
        let url = giveURL(path: "/login")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Basic \(createBasicAuthToken(username: username, password: password))", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
               let userToken = try? jsonDecoder.decode(UserTokenDTO.self, from: data) {
                completion(userToken)
            } else {
                print("Either no data was returned, or data was not properly decoded.")
                
                completion(nil)
                return
            }
        }
        
        task.resume()
    }
    
    /// Get a specific user from the backend
    /// - Parameters:
    ///     - token: The bearer token for authentification on the backend
    /// Returns a User
    func fetchUser(token: String, completion: @escaping (User?) -> Void) {
        
        let url = giveURL(path: "/me")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
               let user = try? jsonDecoder.decode(User.self, from: data) {
                completion(user)
            } else {
                print("Either no data was returned, or data was not properly decoded.")
                
                completion(nil)
                return
            }
        }
        
        task.resume()
    }
    
    /// Register a new user in the backend
    /// - Parameters:
    ///     - user: The new user to register on the backend
    /// Returns a User
    func register(user: RegisterDTO, completion: @escaping (User?) -> Void) {
        let url = giveURL(path: "/users")
        
        let jsonEncoder = JSONEncoder()
        
        let json = try? jsonEncoder.encode(user)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = json
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            
            if let data = data,
               let user = try? jsonDecoder.decode(User.self, from: data) {
                completion(user)
            } else {
                print("Either no data was returned, or data was not properly decoded.")
                
                completion(nil)
                return
            }
        }
        
        task.resume()
    }
    
    
    /**
     SOURCE: https://stackoverflow.com/questions/24379601/how-to-make-an-http-request-basic-auth-in-swift
     */
    private func createBasicAuthToken(username: String, password: String) -> String {
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        return base64LoginString;
    }
    
    private func giveURL(path: String) -> URL {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "127.0.0.1"
        components.port = 8080
        components.path = path
        
        return components.url!
    }
}
