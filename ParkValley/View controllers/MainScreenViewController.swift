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
    
    override func viewDidAppear(_ animated: Bool) {
        let encodedUser = User.loadFromFile()

        if encodedUser == nil {
            print("NOT LOGGED IN")
            performSegue(withIdentifier: "sgShowLogin", sender: self)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
