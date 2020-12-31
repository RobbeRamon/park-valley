//
//  RegisterDTO.swift
//  ParkValley
//
//  Created by Robbe on 31/12/2020.
//

import Foundation

struct RegisterDTO : Codable {
    var email: String
    var username: String
    var password: String
    var confirmPassword: String
}
