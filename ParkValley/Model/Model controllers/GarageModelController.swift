//
//  GarageModelController.swift
//  ParkValley
//
//  Created by Robbe on 16/11/2020.
//

import Foundation

class GarageModelController {
    
    func fetchGarages(completion: @escaping ([Garage]) -> Void) {
        
        
        var components = URLComponents()
        components.scheme = "http"
        components.host = "localhost:8080"
        components.path = "/garages"
        components.queryItems = [
            URLQueryItem(name: "Authorization", value: "Bearer i4iGriDa+aWXCKcVlEEvpQ==")
        ]
        
        
        let url = components.url!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
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
}
