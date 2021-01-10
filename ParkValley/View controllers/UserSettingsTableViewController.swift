//
//  UserSettingsTableViewController.swift
//  ParkValley
//
//  Created by Robbe on 10/01/2021.
//

import UIKit

class UserSettingsTableViewController: UITableViewController {
    @IBOutlet var txUsername: UITextField!
    @IBOutlet var lbEmail: UILabel!
    
    var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        user = User.loadFromFile()
        createUI()
    }
    
    // MARK: - Helper functions
    
    private func createUI() {
        txUsername.text = user.username
        lbEmail.text = user.email
    }

}
