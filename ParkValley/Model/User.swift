//
//  User.swift
//  ParkValley
//
//  Created by Robbe on 08/11/2020.
//

import Foundation

class User : Codable {
    var id : String?
    var username : String?
    var email : String?
    
    init(){}
    
    init(id: String, username: String, email: String) {
        self.id = id
        self.username = username
        self.email = email
    }
    
    static func saveToFile (_ user: User) {
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent("saved_user").appendingPathExtension("plist")
        
        let propertyListEncoder = PropertyListEncoder()
        let encodedUser = try? propertyListEncoder.encode(user)
        
        try? encodedUser?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadFromFile() -> User? {
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent("saved_user").appendingPathExtension("plist")
        
        let propertyListDecoder = PropertyListDecoder()
        
        if let retrievedNotesData = try? Data(contentsOf: archiveURL), let decodedUser = try? propertyListDecoder.decode(User.self, from: retrievedNotesData) {
            //try? FileManager.default.removeItem(at: archiveURL)
            return decodedUser
        }
        
        return nil
    }
    
    static func deleteFromFile() -> Void {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent("saved_user").appendingPathExtension("plist")
        
        try? FileManager.default.removeItem(at: archiveURL)
    }
    
    
}
