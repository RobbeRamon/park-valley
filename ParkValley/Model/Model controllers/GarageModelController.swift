//
//  GarageModelController.swift
//  ParkValley
//
//  Created by Robbe on 16/11/2020.
//

import Foundation

class GarageModelController {
    
    func fetchGarages(searchTerm: String, token: String, completion: @escaping ([Garage]) -> Void) {
        
        print("trigger")
        
        var query = [URLQueryItem]()
        query.append(URLQueryItem(name: "city", value: searchTerm))
        
        let url = giveURL(path: "/garages", query: query)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            
            if let data = data,
               let garages = try? jsonDecoder.decode(Array<Garage>.self, from: data) {
                completion(garages)
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
        components.scheme = "https"
        components.host = "b8ff6c4c13de.ngrok.io"
        //components.port = 8080
        components.path = path
        
        if let query = query {
            components.queryItems = query
        }
        
        return components.url!
    }
}
