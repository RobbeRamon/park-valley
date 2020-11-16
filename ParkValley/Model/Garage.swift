//
//  Garage.swift
//  ParkValley
//
//  Created by Robbe on 08/11/2020.
//

import Foundation

class Garage : Codable {
    var id : String
    var name : String
    var city : String
    var latitude : Double
    var longitude : Double
    var user : User
    
    init(id: String, name: String, city: String, latitude: Double, longitude: Double, user: User) {
        self.id = id
        self.name = name
        self.city = city
        self.latitude = latitude
        self.longitude = longitude
        self.user = user
    }
}
