//
//  ProfileViewController.swift
//  ParkValley
//
//  Created by Robbe on 20/12/2020.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet var ivProfilePicture: UIImageView!
    @IBOutlet var tvOptions: UIView!
    @IBOutlet var lbUsername: UILabel!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user = User.loadFromFile()
        createUI()
    }
    
    // MARK: - Helper functions
    private func createUI() {
        ivProfilePicture.layer.masksToBounds = false
        ivProfilePicture.layer.cornerRadius = ivProfilePicture.frame.height/2
        ivProfilePicture.clipsToBounds = true
        
        lbUsername.text = user.username
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgLogout" {
            User.deleteFromFile()
            UserDefaults.standard.removeObject(forKey: "bearer-token")
        }
    }
}
