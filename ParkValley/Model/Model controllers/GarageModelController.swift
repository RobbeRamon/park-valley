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
        components.scheme = "http"
        components.host = "127.0.0.1"
        components.port = 8080
        components.path = path
        
        if let query = query {
            components.queryItems = query
        }
        
        return components.url!
    }
    
    func saveHistoryToFile (_ garages: [Garage]) {
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent("garage_history").appendingPathExtension("plist")
        
        let propertyListEncoder = PropertyListEncoder()
        let encodedGarages = try? propertyListEncoder.encode(garages)
        
        try? encodedGarages?.write(to: archiveURL, options: .noFileProtection)
    }
    
    func loadHistoryFromFile() -> [Garage]? {
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent("garage_history").appendingPathExtension("plist")
        
        let propertyListDecoder = PropertyListDecoder()
        
        
        if let retrievedNotesData = try? Data(contentsOf: archiveURL), let decodedGarages = try? propertyListDecoder.decode([Garage].self, from: retrievedNotesData) {
            //try? FileManager.default.removeItem(at: archiveURL)
            return decodedGarages
        }
        
        
        return []
    }
}
