//
//  UserModelController.swift
//  ParkValley
//
//  Created by Robbe on 21/11/2020.
//

import Foundation

class UserModelController {
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
        components.scheme = "https"
        components.host = "b8ff6c4c13de.ngrok.io"
        //components.port = 8080
        components.path = path
        
        return components.url!
    }
}
