//
//  Garage.swift
//  ParkValley
//
//  Created by Robbe on 08/11/2020.
//

import Foundation

class Garage : Codable, Equatable {
    var id : String?
    var name : String?
    var city : String?
    var latitude : Double?
    var longitude : Double?
    var user : User?
    var favorite: Bool?
    var description: String?
    
    init(){}
    
    init(id: String?, name: String, city: String, description: String, latitude: Double, longitude: Double, user: User?, favorite: Bool?) {
        self.id = id
        self.name = name
        self.city = city
        self.latitude = latitude
        self.longitude = longitude
        self.user = user
        self.favorite = false
        self.description = description
    }
    
    static func == (lhs: Garage, rhs: Garage) -> Bool {
        return lhs.id == rhs.id
    }
}
