//
//  DataProvider.swift
//  ParkValley
//
//  Created by Robbe on 07/01/2021.
//

import Foundation

class DataProvider {
    
    static let garageModelController = GarageModelController()
    
    static func getString() -> String {
        // This is a test garage, this can be filled with information from the backend
        return "ParkValley\nBook now!"
    }
    
}
