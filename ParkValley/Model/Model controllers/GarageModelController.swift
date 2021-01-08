//
//  GarageModelController.swift
//  ParkValley
//
//  Created by Robbe on 16/11/2020.
//

import Foundation
import SwiftUI

class GarageModelController {
    
    @AppStorage("garage", store: UserDefaults(suiteName: "group.com.robberamon.ParkValley"))
    var garageData: Data = Data()
    
    // MARK: - Server communication
    
    func fetchGarages(searchTerm: String, token: String, completion: @escaping ([Garage]) -> Void) {

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
    
    func fetchAvailableDates(garage: Garage, token: String, dateRange: DateRangeDTO, completion: @escaping ([Date]) -> Void) {
        let query = [URLQueryItem]()
        let url = giveURL(path: "/garages/\(garage.id ?? "")/availableDays", query: query)
        
        let jsonEncoder = JSONEncoder()
        jsonEncoder.dateEncodingStrategy = .iso8601
        
        let json = try? jsonEncoder.encode(dateRange)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = json
        
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
            jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
            
            if let data = data,
               let dates = try? jsonDecoder.decode(Array<Date>.self, from: data) {
                completion(dates)
            } else {
                print("Either no data was returned, or data was not properly decoded.")
                
                completion([])
                return
            }
        }
        
        task.resume()
    }
    
    func addBooking(garage: Garage, token: String, date: Date, completion: @escaping (Booking?) -> Void) {
        let bookingDTO = BookingDTO(name: garage.name ?? "", date: date)
        
        let query = [URLQueryItem]()
        let url = giveURL(path: "/garages/\(garage.id ?? "")/addBooking", query: query)
        
        let jsonEncoder = JSONEncoder()
        jsonEncoder.dateEncodingStrategy = .iso8601
        
        let json = try? jsonEncoder.encode(bookingDTO)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = json
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
            jsonDecoder.dateDecodingStrategy = .iso8601
            
            if let data = data,
               let booking = try? jsonDecoder.decode(Booking.self, from: data) {
                completion(booking)
            } else {
                print("Either no data was returned, or data was not properly decoded.")
                
                completion(nil)
                return
            }
        }
        
        task.resume()
    }
    
    func fetchOwnedGarages(userId: String, token: String, completion: @escaping ([Garage]) -> Void) {
        let query = [URLQueryItem]()
        
        let url = giveURL(path: "/users/\(userId)/garages", query: query)
        
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
    
    func fetchFavouriteGarages(userId: String, token: String, completion: @escaping ([Garage]) -> Void) {
        let query = [URLQueryItem]()
        
        let url = giveURL(path: "/users/\(userId)/garages/favourite", query: query)
        
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
    
    
    func removeGarage(garage: Garage, token: String, completion: @escaping (Bool) -> Void) {
        let query = [URLQueryItem]()
        
        let url = giveURL(path: "/garages/\(garage.id!)", query: query)
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            completion(error == nil)
        }
        
        task.resume()
    }
    
    func switchFavor(garage: Garage, token: String, completion: @escaping (Bool) -> Void) {
        let query = [URLQueryItem]()
        
        var favorAction: String
        
        if garage.favorite == true {
            favorAction = "favor"
        } else {
            favorAction = "defavor"
        }
        
        let url = giveURL(path: "/garages/\(garage.id!)/\(favorAction)", query: query)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            completion(error == nil)
        }
        
        task.resume()
    }
    
    func addGarage(garage: Garage, token: String, completion: @escaping (Garage?) -> Void) {
        
        
        let query = [URLQueryItem]()
        let url = giveURL(path: "/garages/\(garage.id ?? "")", query: query)
        
        let jsonEncoder = JSONEncoder()
        jsonEncoder.dateEncodingStrategy = .iso8601
        
        let json = try? jsonEncoder.encode(garage)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = json
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            
            if let data = data,
               let garage = try? jsonDecoder.decode(Garage.self, from: data) {
                completion(garage)
            } else {
                print("Either no data was returned, or data was not properly decoded.")
                
                completion(nil)
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
    
    
    // MARK: - Local communication
    
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
    
    func removeHistoryFromFile() {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent("garage_history").appendingPathExtension("plist")
        try? FileManager.default.removeItem(at: archiveURL)
        
        // remove the garage for the widget
        garageData.removeAll()
    }
    
    func saveHistoryToFile (_ garages: [Garage]) {
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent("garage_history").appendingPathExtension("plist")
        
        let propertyListEncoder = PropertyListEncoder()
        let encodedGarages = try? propertyListEncoder.encode(garages)
        
        try? encodedGarages?.write(to: archiveURL, options: .noFileProtection)
        
        // set the latest garage for the widget
        garageData.removeAll()
        
        if garages.count > 0 {
            guard let garageData = try? JSONEncoder().encode(garages[0]) else {return}
            self.garageData = garageData
        }
        
        
    }
    

    
    

}
