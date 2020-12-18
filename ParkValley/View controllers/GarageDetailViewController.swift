//
//  GarageDetailViewController.swift
//  ParkValley
//
//  Created by Robbe on 23/11/2020.
//

import UIKit
import MapKit

class GarageDetailViewController: UIViewController {
    
    @IBOutlet var niName: UINavigationItem!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblDescription: UILabel!
    @IBOutlet var ivImage: UIImageView!
    @IBOutlet var mvLocation: MKMapView!
    
    var garage: Garage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgShowOnMap" {
            let garageShowMapViewController = segue.destination as! GarageShowMapViewController
            
            garageShowMapViewController.garage = self.garage
        }
    }
    
    // MARK: - Helper functions
    func updateUI() {
        if let garage = self.garage {
            niName.title = garage.name
            lblTitle.text = garage.name
        }
    }

}
