//
//  GarageDetailViewController.swift
//  ParkValley
//
//  Created by Robbe on 23/11/2020.
//

import UIKit

class GarageDetailViewController: UIViewController {
    
    @IBOutlet var lblName: UILabel!
    @IBOutlet var ivImage: UIImageView!
    
    var garage: Garage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    // MARK: - Helper functions
    func updateUI() {
        if let garage = self.garage {
            lblName.text = garage.name
        }
    }
    

}
