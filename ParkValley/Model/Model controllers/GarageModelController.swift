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
    
    /// Gets all the garages from the backend that have a specific city
    /// - Parameters:
    ///     - searchTerm: The city that needs to be given to the backend
    ///     - token: The bearer token for authentification on the backend
    /// Returns a list of Garages
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
    
    /// Gets the available booking days from the backend within a date range
    /// - Parameters:
    ///     - garage: The garage to fetch the available dates from
    ///     - token: The bearer token for authentification on the backend
    ///     - dateRange: The range the available dates should be in
    /// Returns a list of Dates
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
    
    /// Add a new booking to the backend
    /// - Parameters:
    ///     - garage: The garage to fetch the available dates from
    ///     - token: The bearer token for authentification on the backend
    ///     - date: The date of the booking
    /// Returns a Booking
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
    
    /// Gets all the garages that are owned by a specific user from the backend
    /// - Parameters:
    ///     - userId: The ID of the user to fetch the owned garages from
    ///     - token: The bearer token for authentification on the backend
    /// Returns a list of Garages
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
    
    /// Gets all the favourite garages from a specific user from the backend
    /// - Parameters:
    ///     - userId: The garage to fetch the favourite garages from
    ///     - token: The bearer token for authentification on the backend
    /// Returns a list of Garages
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
    
    /// Removes a garage in the backend
    /// - Parameters:
    ///     - garage: The garage to fetch the available dates from
    ///     - token: The bearer token for authentification on the backend
    /// Returns a boolean
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
    
    /// Switches the favor of a garage (favourite or not)
    /// - Parameters:
    ///     - garage: The garage to switch the favor
    ///     - token: The bearer token for authentification on the backend
    /// Returns a boolean
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
    
    /// Adds a new garage to the backend
    /// - Parameters:
    ///     - garage: The new garage to add to the backend
    ///     - token: The bearer token for authentification on the backend
    /// Returns a Garage
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
    
    /// Loads the recent view history of garages from garage_history.plist
    /// Returns a list of Garages
    func loadHistoryFromFile() -> [Garage]? {
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent("garage_history").appendingPathExtension("plist")
        
        let propertyListDecoder = PropertyListDecoder()
        
        
        if let retrievedNotesData = try? Data(contentsOf: archiveURL),
           let decodedGarages = try? propertyListDecoder.decode([Garage].self,
                                                                from: retrievedNotesData) {
            //try? FileManager.default.removeItem(at: archiveURL)
            return decodedGarages
        }
        
        
        return []
    }
    
    /// Removes all the history stored in garage_history.plist
    func removeHistoryFromFile() {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent("garage_history").appendingPathExtension("plist")
        try? FileManager.default.removeItem(at: archiveURL)
        
        // remove the garage for the widget
        garageData.removeAll()
    }
    
    /// Saves a new list of Garages to the garage_history.plist
    /// - Parameters:
    ///     - garages: The list of the garages
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
