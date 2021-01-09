//
//  ProfileOptionsTableViewController.swift
//  ParkValley
//
//  Created by Robbe on 21/12/2020.
//

import UIKit

class ProfileOptionsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "sgShowFavorites" {
            
            let controller = segue.destination as! ProfileGaragesTableViewController
            controller.garageListType = .favorite
            
        } else if segue.identifier == "sgShowbookings" {
            
            let controller = segue.destination as! ProfileGaragesTableViewController
            controller.garageListType = .booked
            
        } else if segue.identifier == "sgShowMyGarages" {
            
            let controller = segue.destination as! ProfileGaragesTableViewController
            controller.garageListType = .owned
            
        }
    }

}
