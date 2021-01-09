//
//  MainScreenViewController.swift
//  ParkValley
//
//  Created by Robbe on 14/11/2020.
//

import UIKit

class MainScreenViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// Checks if the user is logged in
    /// If not, it shows the login screen
    override func viewDidAppear(_ animated: Bool) {
        let encodedUser = User.loadFromFile()

        if encodedUser == nil {
            print("NOT LOGGED IN")
            performSegue(withIdentifier: "sgShowLogin", sender: self)
        }
    }
}
