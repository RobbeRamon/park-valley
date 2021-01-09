//
//  BookingModelController.swift
//  ParkValley
//
//  Created by Robbe on 01/01/2021.
//

import Foundation

class BookingModelController {
    
    /// Gets all the bookings from one user from the backend
    /// - Parameters:
    ///     - userId: The ID of the user to fetch the bookings from
    ///     - token: The bearer token for authentification on the backend
    /// Returns a list of bookings
    func fetchBookings(userId: String, token: String, completion: @escaping ([BookingDTO]) -> Void) {

        let query = [URLQueryItem]()
        
        let url = giveURL(path: "/users/\(userId)/bookings", query: query)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .iso8601
            
            if let data = data,
               let bookings = try? jsonDecoder.decode(Array<BookingDTO>.self, from: data) {
                completion(bookings)
            } else {
                print("Either no data was returned, or data was not properly decoded.")
                
                completion([])
                return
            }
        }
        
        task.resume()
        
    }
    
    private func giveURL(path: String, query: [URLQueryItem]?) -> URL {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "127.0.0.1"
        components.port = 8080
        components.path = path
        
        if let query = query {
            components.queryItems = query
        }
        
        return components.url!
    }
}
