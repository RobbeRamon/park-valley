//
//  Booking.swift
//  ParkValley
//
//  Created by Robbe on 21/12/2020.
//

import Foundation

class Booking : Codable {
    var id : String?
    var date : Date?
    
    init(){}
    
    init(id: String, date: Date) {
        self.id = id
        self.date = date
    }
    
    
}

